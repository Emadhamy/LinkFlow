# 📱 LinkFlow APK Builder Guide

دليل شامل لإنشاء تطبيق Android (APK) من LinkFlow

## 🎯 الطرق المتاحة

### 1️⃣ **PWA Builder** (الأسهل - 5 دقائق) ⭐

الطريقة الموصى بها للمبتدئين:

1. **اذهب إلى:** https://www.pwabuilder.com/
2. **أدخل رابط تطبيقك:** `https://your-domain.com/linkflow`
3. **اختر Android** من الخيارات
4. **حمّل APK** تلقائياً

**المميزات:**
- ✅ لا يحتاج متطلبات محلية
- ✅ توقيع تلقائي
- ✅ أحدث إصدار Android
- ✅ جاهز للـ Google Play Store

---

### 2️⃣ **Cordova CLI** (المحترفين - 30 دقيقة)

للتحكم الكامل والتخصيص:

#### **أ. التثبيت الأولي**

```bash
# 1. تثبيت Java 17
sdk install java 17.0.17-amzn

# 2. تثبيت Android SDK
# Linux:
sudo apt install android-sdk android-sdk-build-tools

# macOS:
brew install android-sdk

# Windows:
# حمّل من: https://developer.android.com/studio

# 3. تثبيت Cordova
npm install -g cordova

# 4. تعيين متغيرات البيئة
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

#### **ب. البناء السريع**

```bash
# في مجلد LinkFlow:
./build-apk.sh build

# أو خطوة بخطوة:
./build-apk.sh check    # التحقق من المتطلبات
./build-apk.sh create   # إنشاء المشروع
./build-apk.sh copy     # نسخ الملفات
./build-apk.sh build    # البناء النهائي
```

#### **ج. البناء اليدوي**

```bash
cd linkflow-cordova
cordova platform add android
cordova build android --release

# APK سيكون هنا:
# platforms/android/app/build/outputs/apk/release/app-release.apk
```

---

### 3️⃣ **Docker** (الخيار الموثوق)

```bash
# بناء صورة Docker
docker build -t linkflow-builder .

# تشغيل البناء
docker run --rm -v $(pwd):/app/output linkflow-builder

# APK سيكون في مجلد output/
```

---

### 4️⃣ **GitHub Actions** (CI/CD)

**إنشاء `.github/workflows/build-apk.yml`:**

```yaml
name: Build APK

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Java
        uses: actions/setup-java@v2
        with:
          java-version: 17
      - name: Setup Android SDK
        uses: android-actions/setup-android@v2
      - name: Install Cordova
        run: npm install -g cordova
      - name: Build
        run: ./build-apk.sh build
      - name: Upload
        uses: actions/upload-artifact@v2
        with:
          name: LinkFlow-APK
          path: LinkFlow-*.apk
```

---

## 🔧 حل المشاكل الشائعة

### ❌ خطأ: `ANDROID_HOME not found`

**الحل:**
```bash
# Linux/macOS:
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Windows:
setx ANDROID_HOME "C:\Android\Sdk"
setx PATH "%PATH%;%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools"
```

### ❌ خطأ: `Unsupported class file major version`

**الحل:**
```bash
# استخدم Java 17 أو أقدم
sdk use java 17.0.17-amzn
java -version  # تأكد من الإصدار
```

### ❌ خطأ: `Build failed: gradle not found`

**الحل:**
```bash
# تثبيت Gradle
brew install gradle  # macOS

# أو استخدم gradle wrapper:
cd linkflow-cordova/android
./gradlew build
```

### ❌ خطأ: `SDK location not found`

**الحل:**
```bash
# أنشئ ملف local.properties في مجلد android/:
echo "sdk.dir=$ANDROID_HOME" > android/local.properties

# أو يدويًا:
# افتح: platforms/android/local.properties
# أضف: sdk.dir=/path/to/android/sdk
```

### ❌ خطأ: `No permission to execute 'gradlew'`

**الحل:**
```bash
chmod +x linkflow-cordova/platforms/android/gradlew
```

---

## 📦 توقيع APK (للنشر على Store)

### إنشاء مفتاح التوقيع:

```bash
keytool -genkey -v -keystore linkflow.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias linkflow_key

# الإجابة على الأسئلة:
# First and last name: LinkFlow
# Organization: Your Company
# Country Code: EG
```

### البناء مع التوقيع:

```bash
cordova build android --release -- \
  --keystore=linkflow.keystore \
  --storePassword=your_password \
  --alias=linkflow_key \
  --password=your_password
```

---

## 📱 مواصفات الإخراج

**ملف APK النهائي:**
- **الاسم:** `LinkFlow-{timestamp}.apk`
- **الحجم:** ~5-10 MB
- **الإصدار:** بناءً على إصدار Android
- **التوقيع:** موقع ومجهز للنشر

---

## 🚀 النشر على Google Play Store

### الخطوات:
1. **أنشئ حساب Google Play Developer** ($25)
2. **أنشئ تطبيق جديد**
3. **حمّل APK الموقع**
4. **أكمل التفاصيل والصور**
5. **ارفع للمراجعة**

**الملفات المطلوبة:**
- ✅ APK الموقع
- ✅ أيقونة 512x512 PNG
- ✅ صور للمعاينة (2 على الأقل)
- ✅ وصف التطبيق بالعربية

---

## 📋 قائمة التحقق (Checklist)

قبل النشر، تأكد من:

- [ ] التطبيق يعمل على جهاز حقيقي
- [ ] جميع الوظائف تعمل
- [ ] WhatsApp Integration يعمل
- [ ] الكاميرا والميكروفون (إن وجدت) تعمل
- [ ] معلومات الخصوصية محدّثة
- [ ] رقم الإصدار محدّث
- [ ] APK موقع بمفتاح صحيح
- [ ] اختبار على أجهزة مختلفة

---

## 🔗 روابط مفيدة

| الموضوع | الرابط |
|---------|--------|
| PWA Builder | https://www.pwabuilder.com/ |
| Cordova | https://cordova.apache.org/ |
| Android SDK | https://developer.android.com/studio |
| Java Downloads | https://www.oracle.com/java/technologies/downloads/ |
| Google Play Console | https://play.google.com/console |
| Android Guidelines | https://developer.android.com/docs |

---

## ❓ أسئلة شائعة

**س: ما الفرق بين Debug و Release APK؟**
> - **Debug:** للاختبار المحلي (أكبر حجم، أبطأ)
> - **Release:** للنشر (أصغر حجم، أسرع)

**س: كيف أختبر APK قبل النشر؟**
```bash
# استخدم Android Emulator أو جهاز حقيقي
adb install LinkFlow.apk
```

**س: هل يمكن تحديث التطبيق؟**
> نعم، غيّر رقم الإصدار في `config.xml` وأنشئ APK جديد

**س: كم يستغرق البناء؟**
> - أول مرة: 10-15 دقيقة
> - المرات اللاحقة: 3-5 دقائق

---

## 📞 الدعم

للمساعدة، تحقق من:
- 📄 [BUILD_APK.md](BUILD_APK.md) - دليل مفصل
- 🔧 ملف `build-apk.sh` - السكريبت التلقائي
- 📝 `config.xml` - الإعدادات
- 🐳 `Dockerfile` - البناء بـ Docker

---

**تم آخر تحديث:** 2026-01-24
