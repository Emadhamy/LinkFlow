# ✅ GitHub Actions Configuration

تم إعداد **GitHub Actions** لبناء APK تلقائياً! 🎉

## 🚀 البدء السريع

### 1️⃣ أول push بعد الإعداد

```bash
git add .
git commit -m "Setup GitHub Actions"
git push origin main
```

### 2️⃣ اذهب إلى Actions

1. افتح: **GitHub → Actions**
2. ستجد: **Build APK** و **Build & Sign APK**
3. انتظر إلى ينتهي البناء ✅

### 3️⃣ حمّل APK

- **Artifacts** → Select **LinkFlow-Debug** أو **LinkFlow-Release**

---

## 📊 الـ Workflows

| الـ Workflow | التشغيل | الملفات |
|-------------|--------|--------|
| **Build APK** | Auto on push | Debug + Release |
| **Build & Sign** | Manual/Tags | Signed APK |

---

## 🎮 كيفية الاستخدام

### الاستخدام التلقائي (Automatic)
```bash
git push origin main  # ✅ يبني تلقائياً
```

### الاستخدام اليدوي (Manual)
1. GitHub → Actions → Build & Sign APK
2. Run workflow → بناء يدوي

### إنشاء Release
```bash
git tag v1.0.0
git push origin v1.0.0  # ✅ ينشئ Release تلقائياً
```

---

## 📁 الملفات المنشأة

```
.github/
├── workflows/
│   ├── build-apk.yml          ← البناء التلقائي (على كل push)
│   └── build-release.yml      ← البناء المتقدم (يدوي/tags)
└── GITHUB_ACTIONS_GUIDE.md    ← دليل شامل
```

---

## 💡 ملاحظات مهمة

✅ **يحدث تلقائياً:**
- البناء عند كل push على main
- عند إنشاء pull request
- عند إنشاء Release/Tag

⚠️ **مدة البناء:**
- أول مرة: 15-20 دقيقة
- المرات اللاحقة: 10-15 دقيقة (بسبب cache)

📦 **الملفات المُنتجة:**
- `LinkFlow-Debug-APK` (للاختبار)
- `LinkFlow-Release-APK` (للنشر)
- Release files (إذا تم إنشاء tag)

---

## 🔗 روابط مهمة

- 📄 [دليل شامل](.github/GITHUB_ACTIONS_GUIDE.md)
- 🔧 [build-apk workflow](.github/workflows/build-apk.yml)
- 🚀 [build-release workflow](.github/workflows/build-release.yml)

---

**الآن APK يُبنى تلقائياً عند كل تحديث! 🎉**
