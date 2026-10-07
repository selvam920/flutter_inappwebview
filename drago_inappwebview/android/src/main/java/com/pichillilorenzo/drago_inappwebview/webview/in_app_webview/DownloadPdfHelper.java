package com.pichillilorenzo.drago_inappwebview.webview.in_app_webview;

import android.app.DownloadManager;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.print.DragoPdfPrinter;
import android.print.PrintAttributes;
import android.print.PrintDocumentAdapter;
import android.provider.MediaStore;
import android.util.Base64;
import android.util.Log;
import android.webkit.CookieManager;
import android.webkit.URLUtil;
import android.webkit.ValueCallback;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.pichillilorenzo.drago_inappwebview.print_job.PrintJobSettings;
import com.pichillilorenzo.drago_inappwebview.types.DownloadStartRequest;
import com.pichillilorenzo.drago_inappwebview.types.MarginsExt;

import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.plugin.common.MethodChannel;

/** Native SAVE for onDownloadStarting and createPdf on Android. */
public class DownloadPdfHelper {
  static final String LOG_TAG = "DragoDownloadPdf";
  private static final Handler mainHandler = new Handler(Looper.getMainLooper());
  private static final ExecutorService io = Executors.newCachedThreadPool();

  // ---------------------------------------------------------------- downloads

  public static void save(@NonNull final InAppWebView webView, @NonNull DownloadStartRequest request,
                          @Nullable final String resultFilePath) {
    final Context context = webView.getContext().getApplicationContext();
    final String url = request.getUrl();
    final String mimeType = request.getMimeType();
    final String fileName = request.getSuggestedFilename() != null ? request.getSuggestedFilename()
            : URLUtil.guessFileName(url, request.getContentDisposition(), mimeType);
    try {
      if (url.startsWith("data:")) {
        writeAsync(context, decodeDataUrl(url), resultFilePath, fileName, mimeType);
      } else if (url.startsWith("blob:")) {
        String body = "const r = await fetch(url); const b = await r.blob();"
                + "return await new Promise((res, rej) => { const fr = new FileReader();"
                + "fr.onload = () => res(fr.result); fr.onerror = () => rej(fr.error); fr.readAsDataURL(b); });";
        Map<String, Object> args = new HashMap<>();
        args.put("url", url);
        webView.callAsyncJavaScript(body, args, null, new ValueCallback<String>() {
          @Override
          public void onReceiveValue(String value) {
            try {
              JSONObject json = new JSONObject(value);
              String dataUrl = json.optString("value", null);
              if (dataUrl == null || !dataUrl.startsWith("data:")) {
                Log.e(LOG_TAG, "blob download failed: " + json.optString("error"));
                return;
              }
              writeAsync(context, decodeDataUrl(dataUrl), resultFilePath, fileName, mimeType);
            } catch (Exception e) {
              Log.e(LOG_TAG, "blob download failed", e);
            }
          }
        });
      } else if (resultFilePath != null) {
        downloadToPath(url, request.getUserAgent(), resultFilePath);
      } else {
        DownloadManager.Request dm = new DownloadManager.Request(Uri.parse(url));
        String cookies = CookieManager.getInstance().getCookie(url);
        if (cookies != null) dm.addRequestHeader("Cookie", cookies);
        if (request.getUserAgent() != null) dm.addRequestHeader("User-Agent", request.getUserAgent());
        if (mimeType != null) dm.setMimeType(mimeType);
        dm.setTitle(fileName);
        dm.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
        dm.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, fileName);
        DownloadManager manager = (DownloadManager) context.getSystemService(Context.DOWNLOAD_SERVICE);
        if (manager != null) manager.enqueue(dm);
      }
    } catch (Exception e) {
      Log.e(LOG_TAG, "download failed", e);
    }
  }

  static byte[] decodeDataUrl(String url) throws Exception {
    int comma = url.indexOf(',');
    if (comma < 0) throw new IllegalArgumentException("bad data url");
    String meta = url.substring(5, comma);
    String data = url.substring(comma + 1);
    if (meta.endsWith(";base64")) {
      return Base64.decode(data, Base64.DEFAULT);
    }
    return URLDecoder.decode(data.replace("+", "%2B"), "UTF-8").getBytes("UTF-8");
  }

  private static void writeAsync(final Context context, final byte[] bytes, @Nullable final String path,
                                 final String fileName, @Nullable final String mimeType) {
    io.execute(new Runnable() {
      @Override
      public void run() {
        try {
          if (path != null) {
            File f = new File(path);
            File parent = f.getParentFile();
            if (parent != null) parent.mkdirs();
            OutputStream os = new FileOutputStream(f, false);
            try { os.write(bytes); } finally { os.close(); }
          } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            ContentResolver resolver = context.getContentResolver();
            ContentValues values = new ContentValues();
            values.put(MediaStore.Downloads.DISPLAY_NAME, fileName);
            if (mimeType != null) values.put(MediaStore.Downloads.MIME_TYPE, mimeType);
            values.put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS);
            Uri uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values);
            if (uri == null) throw new IllegalStateException("MediaStore insert failed");
            OutputStream os = resolver.openOutputStream(uri);
            if (os == null) throw new IllegalStateException("MediaStore open failed");
            try { os.write(bytes); } finally { os.close(); }
          } else {
            File dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
            dir.mkdirs();
            OutputStream os = new FileOutputStream(new File(dir, fileName), false);
            try { os.write(bytes); } finally { os.close(); }
          }
        } catch (Exception e) {
          Log.e(LOG_TAG, "write download failed", e);
        }
      }
    });
  }

  private static void downloadToPath(final String url, @Nullable final String userAgent, final String path) {
    io.execute(new Runnable() {
      @Override
      public void run() {
        HttpURLConnection conn = null;
        try {
          conn = (HttpURLConnection) new URL(url).openConnection();
          String cookies = CookieManager.getInstance().getCookie(url);
          if (cookies != null) conn.setRequestProperty("Cookie", cookies);
          if (userAgent != null) conn.setRequestProperty("User-Agent", userAgent);
          conn.setInstanceFollowRedirects(true);
          File f = new File(path);
          File parent = f.getParentFile();
          if (parent != null) parent.mkdirs();
          InputStream is = conn.getInputStream();
          OutputStream os = new FileOutputStream(f, false);
          try {
            byte[] buf = new byte[16384];
            int n;
            while ((n = is.read(buf)) > 0) os.write(buf, 0, n);
          } finally {
            os.close();
            is.close();
          }
        } catch (Exception e) {
          Log.e(LOG_TAG, "download to path failed", e);
        } finally {
          if (conn != null) conn.disconnect();
        }
      }
    });
  }

  // ---------------------------------------------------------------- pdf

  @SuppressWarnings("unchecked")
  public static void createPdf(@NonNull InAppWebView webView, @Nullable Map<String, Object> pdfConfiguration,
                               @NonNull final MethodChannel.Result result) {
    try {
      PrintAttributes.MediaSize mediaSize = PrintAttributes.MediaSize.ISO_A4;
      PrintAttributes.Margins margins = PrintAttributes.Margins.NO_MARGINS;
      Map<String, Object> settingsMap = pdfConfiguration != null
              ? (Map<String, Object>) pdfConfiguration.get("settings") : null;
      if (settingsMap != null) {
        PrintJobSettings settings = new PrintJobSettings().parse(settingsMap);
        if (settings.mediaSize != null) mediaSize = settings.mediaSize.toMediaSize();
        // PrintJobOrientation: 0 = portrait, 1 = landscape
        mediaSize = (settings.orientation != null && settings.orientation == 1)
                ? mediaSize.asLandscape() : mediaSize.asPortrait();
        Object m = settingsMap.get("margins");
        if (m instanceof Map) {
          Map<String, Object> mm = (Map<String, Object>) m;
          margins = new MarginsExt(num(mm.get("top")), num(mm.get("right")),
                  num(mm.get("bottom")), num(mm.get("left"))).toMargins();
        }
      }
      PrintAttributes attributes = new PrintAttributes.Builder()
              .setMediaSize(mediaSize)
              .setResolution(new PrintAttributes.Resolution("pdf", "pdf", 300, 300))
              .setMinMargins(margins)
              .setColorMode(PrintAttributes.COLOR_MODE_COLOR)
              .build();
      final PrintDocumentAdapter adapter = webView.createPrintDocumentAdapter("drago_pdf");
      final File out = File.createTempFile("drago_pdf", ".pdf", webView.getContext().getCacheDir());
      DragoPdfPrinter.print(adapter, attributes, out, new DragoPdfPrinter.Callback() {
        @Override
        public void onDone(final boolean success) {
          io.execute(new Runnable() {
            @Override
            public void run() {
              byte[] bytes = null;
              if (success) {
                try {
                  InputStream is = new FileInputStream(out);
                  ByteArrayOutputStream bos = new ByteArrayOutputStream();
                  byte[] buf = new byte[16384];
                  int n;
                  while ((n = is.read(buf)) > 0) bos.write(buf, 0, n);
                  is.close();
                  bytes = bos.toByteArray();
                } catch (Exception e) {
                  Log.e(LOG_TAG, "read pdf failed", e);
                }
              }
              //noinspection ResultOfMethodCallIgnored
              out.delete();
              final byte[] finalBytes = (bytes != null && bytes.length > 0) ? bytes : null;
              mainHandler.post(new Runnable() {
                @Override
                public void run() {
                  result.success(finalBytes);
                }
              });
            }
          });
        }
      });
    } catch (Exception e) {
      Log.e(LOG_TAG, "createPdf failed", e);
      result.success(null);
    }
  }

  private static double num(Object o) {
    return o instanceof Number ? ((Number) o).doubleValue() : 0;
  }
}
