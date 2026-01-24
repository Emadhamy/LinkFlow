#!/bin/bash
# LinkFlow APK Builder
# هذا السكريبت يساعد في بناء APK من تطبيق LinkFlow

set -e

echo "🚀 LinkFlow APK Builder"
echo "====================="

# ألوان
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# التحقق من المتطلبات
check_requirements() {
    echo -e "${YELLOW}🔍 التحقق من المتطلبات...${NC}"
    
    if ! command -v java &> /dev/null; then
        echo -e "${RED}❌ Java غير مثبت${NC}"
        echo "قم بتثبيت Java 17 أو أحدث"
        exit 1
    fi
    
    if ! command -v cordova &> /dev/null; then
        echo -e "${RED}❌ Cordova غير مثبت${NC}"
        echo "قم بتثبيت: npm install -g cordova"
        exit 1
    fi
    
    if [ -z "$ANDROID_HOME" ]; then
        echo -e "${YELLOW}⚠️ تحذير: ANDROID_HOME غير محدد${NC}"
        echo "استخدم: export ANDROID_HOME=/path/to/android/sdk"
    fi
    
    echo -e "${GREEN}✓ جميع المتطلبات موجودة${NC}"
}

# إنشاء مشروع Cordova
create_cordova_project() {
    echo -e "${YELLOW}📦 إنشاء مشروع Cordova...${NC}"
    
    if [ -d "linkflow-cordova" ]; then
        read -p "المشروع موجود بالفعل. هل تريد استبداله؟ (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf linkflow-cordova
        else
            echo -e "${GREEN}✓ استخدام المشروع الموجود${NC}"
            return
        fi
    fi
    
    cordova create linkflow-cordova com.linkflow.app "LinkFlow"
    cd linkflow-cordova
    cordova platform add android
    cd ..
    
    echo -e "${GREEN}✓ تم إنشاء مشروع Cordova${NC}"
}

# نسخ الملفات
copy_files() {
    echo -e "${YELLOW}📁 نسخ ملفات LinkFlow...${NC}"
    
    cp index.html manifest.json icon.svg sw.js linkflow-cordova/www/
    
    echo -e "${GREEN}✓ تم نسخ الملفات${NC}"
}

# بناء APK
build_apk() {
    echo -e "${YELLOW}🔨 بناء APK...${NC}"
    
    cd linkflow-cordova
    
    case $1 in
        "debug")
            cordova build android
            OUTPUT_PATH="platforms/android/app/build/outputs/apk/debug/app-debug.apk"
            ;;
        "release")
            cordova build android --release
            OUTPUT_PATH="platforms/android/app/build/outputs/apk/release/app-release.apk"
            ;;
        *)
            cordova build android --release
            OUTPUT_PATH="platforms/android/app/build/outputs/apk/release/app-release.apk"
            ;;
    esac
    
    cd ..
    
    if [ -f "$OUTPUT_PATH" ]; then
        echo -e "${GREEN}✓ تم بناء APK بنجاح!${NC}"
        echo -e "${GREEN}📍 الموقع: $OUTPUT_PATH${NC}"
        cp "$OUTPUT_PATH" "LinkFlow-$(date +%Y%m%d-%H%M%S).apk"
        echo -e "${GREEN}✓ تم نسخ APK إلى المجلد الحالي${NC}"
    else
        echo -e "${RED}❌ فشل بناء APK${NC}"
        exit 1
    fi
}

# الخيارات الرئيسية
case ${1:-build} in
    "check")
        check_requirements
        ;;
    "create")
        check_requirements
        create_cordova_project
        ;;
    "copy")
        copy_files
        ;;
    "build")
        check_requirements
        create_cordova_project
        copy_files
        build_apk "release"
        ;;
    "debug")
        check_requirements
        create_cordova_project
        copy_files
        build_apk "debug"
        ;;
    *)
        echo "الاستخدام: ./build-apk.sh [check|create|copy|build|debug]"
        echo ""
        echo "الخيارات:"
        echo "  check   - التحقق من المتطلبات"
        echo "  create  - إنشاء مشروع Cordova"
        echo "  copy    - نسخ ملفات LinkFlow"
        echo "  build   - بناء APK Release (الخيار الافتراضي)"
        echo "  debug   - بناء APK Debug"
        exit 1
        ;;
esac

echo -e "${GREEN}✅ تم بنجاح!${NC}"
