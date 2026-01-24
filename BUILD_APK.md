# إنشاء APK من LinkFlow

## الطرق المتاحة

### الطريقة 1: استخدام PWA Builder (الأسهل) 🌐
1. اذهب إلى: https://www.pwabuilder.com/
2. أدخل الرابط: `https://your-linkflow-url.com`
3. اختر منصة Android
4. حمّل APK تلقائياً

### الطريقة 2: استخدام Cordova (محلي) 💻

#### المتطلبات:
```bash
# 1. تثبيت Java 17 أو أحدث
sdk install java 17.0.17-amzn

# 2. تثبيت Android SDK
# Linux:
sudo apt install android-sdk android-sdk-build-tools

# macOS:
brew install android-sdk

# Windows:
# حمّل من: https://developer.android.com/studio
```

#### الخطوات:
```bash
# 1. نسخ المشروع
cd /path/to/linkflow-cordova

# 2. تثبيت المتطلبات
npm install

# 3. إضافة منصة Android
cordova platform add android

# 4. نسخ الملفات
cp index.html manifest.json icon.svg sw.js www/

# 5. بناء APK
cordova build android --release

# APK سيكون في:
# platforms/android/app/build/outputs/apk/release/app-release.apk
```

### الطريقة 3: استخدام Android Studio (الأفضل للإنتاج) 🏗️

1. **افتح Android Studio**
2. **اختر: File → New → Import Project**
3. **اختر: `linkflow-cordova/platforms/android`**
4. **اضغط: Build → Build Bundle(s) / APK(s) → Build APK(s)**
5. **ستجد APK في:** `platforms/android/app/build/outputs/apk/`

## ملفات جاهزة

### LinkFlow.zip
- يحتوي على جميع ملفات التطبيق
- جاهز للتحميل على PWA Builder
- صالح للتوزيع

## حل المشاكل الشائعة

### ❌ خطأ: "ANDROID_HOME not found"
```bash
# على Linux/macOS:
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# على Windows:
set ANDROID_HOME=C:\Android\Sdk
```

### ❌ خطأ: "Unsupported class file major version"
```bash
# استخدم Java 17 أو أقدم
sdk use java 17.0.17-amzn
```

### ❌ خطأ: "Could not determine SDK location"
```bash
# أنشئ ملف local.properties في android/:
echo "sdk.dir=$ANDROID_HOME" > android/local.properties
```

## التوقيع (Signing)

للإصدار على Google Play Store:
```bash
cordova build android --release -- --keystore=path/to/keystore.jks --storePassword=password --alias=alias_name --password=password
```

أو استخدم keytool:
```bash
keytool -genkey -v -keystore linkflow.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias linkflow
```

## روابط مفيدة

- [PWA Builder](https://www.pwabuilder.com/)
- [Cordova Documentation](https://cordova.apache.org/docs/en/latest/)
- [Android SDK Setup](https://developer.android.com/studio/install)
- [Java Downloads](https://www.oracle.com/java/technologies/downloads/)
