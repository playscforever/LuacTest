package com.yzj.tools;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import org.cocos2dx.quickstudy1.R;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.util.Log;
import android.widget.Toast;

public class NativeProxy {

	private static Cocos2dxActivity mContext;

	public static void setContext(Cocos2dxActivity context) {
		mContext = context;
		Log.e("yzj", "yzj = setContext success");
	}

	public static void printLog(final String msg) {
		Log.e("yzj", "yzj = " + msg);
	}

	public static void showAlertDialog(final String title,
			final String message, final int luaCallbackFunction) {
		mContext.runOnUiThread(new Runnable() {
			@Override
			public void run() {
				AlertDialog alertDialog = new AlertDialog.Builder(mContext)
						.create();
				alertDialog.setTitle(title);
				alertDialog.setMessage(message);
				alertDialog.setButton("OK",
						new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog,
									int which) {
								mContext.runOnGLThread(new Runnable() {
									@Override
									public void run() {
										Cocos2dxLuaJavaBridge
												.callLuaFunctionWithString(
														luaCallbackFunction,
														"CLICKED");
										Cocos2dxLuaJavaBridge
												.releaseLuaFunction(luaCallbackFunction);
									}
								});
							}
						});
				alertDialog.setIcon(R.drawable.icon);

				alertDialog.show();
			}
		});
	}

	public static void unZip(String unZipfileName, String mDestPath) {
		if (!mDestPath.endsWith("/")) {
			mDestPath = mDestPath + "/";
		}
		try {
			// Charset CP866 = Charset.forName("CP437");
			ZipFile zipFile = new ZipFile(unZipfileName);
			Enumeration<?> e = zipFile.entries();
			// zipIn = new ZipInputStream(new BufferedInputStream(new
			// FileInputStream(unZipfileName)));
			while (e.hasMoreElements()) {
				ZipEntry entry = (ZipEntry) e.nextElement();
				File destinationFilePath = new File(mDestPath, entry.getName());
				System.out.println("unZip ==> " + entry.getName());
				destinationFilePath.getParentFile().mkdirs();
				if (entry.isDirectory()) {
					continue;
				} else {
					System.out.println("Extracting " + destinationFilePath);
					BufferedInputStream bis = new BufferedInputStream(
							zipFile.getInputStream(entry));
					int b;
					byte buffer[] = new byte[1024 * 4];
					FileOutputStream fos = new FileOutputStream(
							destinationFilePath);
					BufferedOutputStream bos = new BufferedOutputStream(fos,
							1024);
					while ((b = bis.read(buffer, 0, 1024)) != -1) {
						bos.write(buffer, 0, b);
					}
					bos.flush();
					bos.close();
					bis.close();
				}
				if (entry.getName().endsWith(".zip")) {
					System.out.println("hehe noway");
					// found a zip file, try to open
					// unzip(destinationFilePath.getAbsolutePath());
				}
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}

	// 递归删除文件及文件夹
	public static void delete(File file) {
		if (file.isFile()) {
			file.delete();
			return;
		}

		if (file.isDirectory()) {
			File[] childFiles = file.listFiles();
			if (childFiles == null || childFiles.length == 0) {
				file.delete();
				return;
			}

			for (int i = 0; i < childFiles.length; i++) {
				delete(childFiles[i]);
			}
			file.delete();
		}
	}

	public static void downloadSth(String Localpath, String remoteFilePath,
			String remoteFileName) {
		// String sdCard = Environment.getExternalStorageDirectory() + "/";
		File dir = new File(Localpath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		System.out.println("yzj " + Localpath);
		File file = new File(Localpath + remoteFileName);
		try {
			file.createNewFile();
			URL url = new URL(remoteFilePath + remoteFileName);
			System.out.println("yzj url = " + remoteFilePath + remoteFileName);
			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();
			InputStream istream = connection.getInputStream();
			OutputStream output = new FileOutputStream(file);
			byte[] buffer = new byte[1024 * 4];
			int numread = 0;
			while ((numread = istream.read(buffer)) != -1) {
				output.write(buffer, 0, numread);
			}
			output.flush();
			output.close();
			istream.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static String getVersion() {
		String appVersion = "";
		PackageManager manager = mContext.getPackageManager();
		try {
			PackageInfo info = manager.getPackageInfo(mContext.getPackageName(), 0);
			appVersion = info.versionName; // 版本名
		} catch (NameNotFoundException e) {
			e.printStackTrace();
		}
		System.out.println("yzj versionName = " + appVersion);
		return appVersion;
	}

	
	public static int getIntValue(){
		System.out.println("yzj getSTringValue()");
		return 1;
	}
	
	public static void doUpgrade(String Localpath, String remoteFilePath,
			String remoteFileName) {
		System.out.println("yzj Localpath" + Localpath);
		System.out.println("yzj remoteFilePath" + remoteFilePath);
		System.out.println("yzj remoteFileName" + remoteFileName);
		delete(new File(Localpath + remoteFileName));
		delete(new File(Localpath + "upgrade"));
		downloadSth(Localpath, remoteFilePath, remoteFileName);
		unZip(Localpath + remoteFileName, Localpath);
		delete(new File(Localpath + remoteFileName));
	}

	public static void t(String str) {
		Toast.makeText(mContext, str, Toast.LENGTH_SHORT).show();
	}

}