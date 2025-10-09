#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>
#include <QtCore/qhash.h>
#include <QtCore/qstring.h>

namespace QmlCacheGeneratedCode {
namespace _0x5f_IPTVPro_qml_App_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_IPTVPro_qml_screens_SplashScreen_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_IPTVPro_qml_screens_OfflineScreen_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_IPTVPro_qml_screens_UpdateRequired_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_IPTVPro_qml_screens_ErrorFallback_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_IPTVPro_qml_components_Toast_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_IPTVPro_qml_components_SkeletonList_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_IPTVPro_qml_components_EmptyState_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
    resourcePathToCachedUnit.insert(QStringLiteral("/IPTVPro/qml/App.qml"), &QmlCacheGeneratedCode::_0x5f_IPTVPro_qml_App_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/IPTVPro/qml/screens/SplashScreen.qml"), &QmlCacheGeneratedCode::_0x5f_IPTVPro_qml_screens_SplashScreen_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/IPTVPro/qml/screens/OfflineScreen.qml"), &QmlCacheGeneratedCode::_0x5f_IPTVPro_qml_screens_OfflineScreen_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/IPTVPro/qml/screens/UpdateRequired.qml"), &QmlCacheGeneratedCode::_0x5f_IPTVPro_qml_screens_UpdateRequired_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/IPTVPro/qml/screens/ErrorFallback.qml"), &QmlCacheGeneratedCode::_0x5f_IPTVPro_qml_screens_ErrorFallback_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/IPTVPro/qml/components/Toast.qml"), &QmlCacheGeneratedCode::_0x5f_IPTVPro_qml_components_Toast_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/IPTVPro/qml/components/SkeletonList.qml"), &QmlCacheGeneratedCode::_0x5f_IPTVPro_qml_components_SkeletonList_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/IPTVPro/qml/components/EmptyState.qml"), &QmlCacheGeneratedCode::_0x5f_IPTVPro_qml_components_EmptyState_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.structVersion = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qmlcache_IPTVPro)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qmlcache_IPTVPro))
int QT_MANGLE_NAMESPACE(qCleanupResources_qmlcache_IPTVPro)() {
    return 1;
}
