# استخدام صورة Android بها كل المتطلبات مثبتة
FROM andrescantelar/android-sdk:latest

WORKDIR /app

# تثبيت Node.js و npm
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    git \
    && rm -rf /var/lib/apt/lists/*

# تثبيت Cordova و Capacitor
RUN npm install -g cordova @capacitor/cli

# نسخ ملفات المشروع
COPY . .

# تثبيت المتطلبات
RUN npm install

# بناء التطبيق
RUN cordova prepare android

# الأمر الافتراضي
CMD ["cordova", "build", "android", "--release"]
