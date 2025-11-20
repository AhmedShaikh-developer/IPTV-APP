/****************************************************************************
** Meta object code from reading C++ file 'VlcPlayer.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../src/VlcPlayer.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'VlcPlayer.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.9.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN9VlcPlayerE_t {};
} // unnamed namespace

template <> constexpr inline auto VlcPlayer::qt_create_metaobjectdata<qt_meta_tag_ZN9VlcPlayerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "VlcPlayer",
        "sourceChanged",
        "",
        "source",
        "stateChanged",
        "state",
        "positionChanged",
        "position",
        "timeChanged",
        "time",
        "lengthChanged",
        "length",
        "volumeChanged",
        "volume",
        "mutedChanged",
        "muted",
        "errorMessageChanged",
        "error",
        "videoOutputChanged",
        "QQuickItem*",
        "videoOutput",
        "playing",
        "paused",
        "stopped",
        "ended",
        "vlcOptionsChanged",
        "options",
        "updateState",
        "setErrorMessage",
        "onVideoOutputWindowChanged",
        "QWindow*",
        "window",
        "play",
        "pause",
        "stop",
        "seek",
        "setTimePosition",
        "setPositionInternal",
        "setTimeInternal",
        "setLengthInternal",
        "errorMessage",
        "vlcOptions",
        "State",
        "Idle",
        "Opening",
        "Buffering",
        "Playing",
        "Paused",
        "Stopped",
        "Ended",
        "Error"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'sourceChanged'
        QtMocHelpers::SignalData<void(const QString &)>(1, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 3 },
        }}),
        // Signal 'stateChanged'
        QtMocHelpers::SignalData<void(int)>(4, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 5 },
        }}),
        // Signal 'positionChanged'
        QtMocHelpers::SignalData<void(float)>(6, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Float, 7 },
        }}),
        // Signal 'timeChanged'
        QtMocHelpers::SignalData<void(int)>(8, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 9 },
        }}),
        // Signal 'lengthChanged'
        QtMocHelpers::SignalData<void(int)>(10, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 11 },
        }}),
        // Signal 'volumeChanged'
        QtMocHelpers::SignalData<void(float)>(12, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Float, 13 },
        }}),
        // Signal 'mutedChanged'
        QtMocHelpers::SignalData<void(bool)>(14, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Bool, 15 },
        }}),
        // Signal 'errorMessageChanged'
        QtMocHelpers::SignalData<void(const QString &)>(16, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 17 },
        }}),
        // Signal 'videoOutputChanged'
        QtMocHelpers::SignalData<void(QQuickItem *)>(18, 2, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 19, 20 },
        }}),
        // Signal 'playing'
        QtMocHelpers::SignalData<void()>(21, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'paused'
        QtMocHelpers::SignalData<void()>(22, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'stopped'
        QtMocHelpers::SignalData<void()>(23, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'ended'
        QtMocHelpers::SignalData<void()>(24, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'error'
        QtMocHelpers::SignalData<void()>(17, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'vlcOptionsChanged'
        QtMocHelpers::SignalData<void(const QStringList &)>(25, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QStringList, 26 },
        }}),
        // Slot 'updateState'
        QtMocHelpers::SlotData<void()>(27, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'setErrorMessage'
        QtMocHelpers::SlotData<void(const QString &)>(28, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 17 },
        }}),
        // Slot 'onVideoOutputWindowChanged'
        QtMocHelpers::SlotData<void(QWindow *)>(29, 2, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 30, 31 },
        }}),
        // Method 'play'
        QtMocHelpers::MethodData<void()>(32, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'pause'
        QtMocHelpers::MethodData<void()>(33, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'stop'
        QtMocHelpers::MethodData<void()>(34, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'seek'
        QtMocHelpers::MethodData<void(int)>(35, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 9 },
        }}),
        // Method 'setTimePosition'
        QtMocHelpers::MethodData<void(float)>(36, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Float, 7 },
        }}),
        // Method 'setPositionInternal'
        QtMocHelpers::MethodData<void(float)>(37, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Float, 7 },
        }}),
        // Method 'setTimeInternal'
        QtMocHelpers::MethodData<void(int)>(38, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 9 },
        }}),
        // Method 'setLengthInternal'
        QtMocHelpers::MethodData<void(int)>(39, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 11 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'source'
        QtMocHelpers::PropertyData<QString>(3, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 0),
        // property 'state'
        QtMocHelpers::PropertyData<int>(5, QMetaType::Int, QMC::DefaultPropertyFlags, 1),
        // property 'position'
        QtMocHelpers::PropertyData<float>(7, QMetaType::Float, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 2),
        // property 'time'
        QtMocHelpers::PropertyData<int>(9, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 3),
        // property 'length'
        QtMocHelpers::PropertyData<int>(11, QMetaType::Int, QMC::DefaultPropertyFlags, 4),
        // property 'volume'
        QtMocHelpers::PropertyData<float>(13, QMetaType::Float, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 5),
        // property 'muted'
        QtMocHelpers::PropertyData<bool>(15, QMetaType::Bool, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 6),
        // property 'errorMessage'
        QtMocHelpers::PropertyData<QString>(40, QMetaType::QString, QMC::DefaultPropertyFlags, 7),
        // property 'videoOutput'
        QtMocHelpers::PropertyData<QQuickItem*>(20, 0x80000000 | 19, QMC::DefaultPropertyFlags | QMC::Writable | QMC::EnumOrFlag | QMC::StdCppSet, 8),
        // property 'vlcOptions'
        QtMocHelpers::PropertyData<QStringList>(41, QMetaType::QStringList, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 14),
    };
    QtMocHelpers::UintData qt_enums {
        // enum 'State'
        QtMocHelpers::EnumData<enum State>(42, 42, QMC::EnumFlags{}).add({
            {   43, State::Idle },
            {   44, State::Opening },
            {   45, State::Buffering },
            {   46, State::Playing },
            {   47, State::Paused },
            {   48, State::Stopped },
            {   49, State::Ended },
            {   50, State::Error },
        }),
    };
    return QtMocHelpers::metaObjectData<VlcPlayer, qt_meta_tag_ZN9VlcPlayerE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject VlcPlayer::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9VlcPlayerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9VlcPlayerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN9VlcPlayerE_t>.metaTypes,
    nullptr
} };

void VlcPlayer::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<VlcPlayer *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->sourceChanged((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->stateChanged((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 2: _t->positionChanged((*reinterpret_cast< std::add_pointer_t<float>>(_a[1]))); break;
        case 3: _t->timeChanged((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 4: _t->lengthChanged((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 5: _t->volumeChanged((*reinterpret_cast< std::add_pointer_t<float>>(_a[1]))); break;
        case 6: _t->mutedChanged((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 7: _t->errorMessageChanged((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 8: _t->videoOutputChanged((*reinterpret_cast< std::add_pointer_t<QQuickItem*>>(_a[1]))); break;
        case 9: _t->playing(); break;
        case 10: _t->paused(); break;
        case 11: _t->stopped(); break;
        case 12: _t->ended(); break;
        case 13: _t->error(); break;
        case 14: _t->vlcOptionsChanged((*reinterpret_cast< std::add_pointer_t<QStringList>>(_a[1]))); break;
        case 15: _t->updateState(); break;
        case 16: _t->setErrorMessage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 17: _t->onVideoOutputWindowChanged((*reinterpret_cast< std::add_pointer_t<QWindow*>>(_a[1]))); break;
        case 18: _t->play(); break;
        case 19: _t->pause(); break;
        case 20: _t->stop(); break;
        case 21: _t->seek((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 22: _t->setTimePosition((*reinterpret_cast< std::add_pointer_t<float>>(_a[1]))); break;
        case 23: _t->setPositionInternal((*reinterpret_cast< std::add_pointer_t<float>>(_a[1]))); break;
        case 24: _t->setTimeInternal((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 25: _t->setLengthInternal((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 8:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QQuickItem* >(); break;
            }
            break;
        case 17:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QWindow* >(); break;
            }
            break;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(const QString & )>(_a, &VlcPlayer::sourceChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(int )>(_a, &VlcPlayer::stateChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(float )>(_a, &VlcPlayer::positionChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(int )>(_a, &VlcPlayer::timeChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(int )>(_a, &VlcPlayer::lengthChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(float )>(_a, &VlcPlayer::volumeChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(bool )>(_a, &VlcPlayer::mutedChanged, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(const QString & )>(_a, &VlcPlayer::errorMessageChanged, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(QQuickItem * )>(_a, &VlcPlayer::videoOutputChanged, 8))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)()>(_a, &VlcPlayer::playing, 9))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)()>(_a, &VlcPlayer::paused, 10))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)()>(_a, &VlcPlayer::stopped, 11))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)()>(_a, &VlcPlayer::ended, 12))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)()>(_a, &VlcPlayer::error, 13))
            return;
        if (QtMocHelpers::indexOfMethod<void (VlcPlayer::*)(const QStringList & )>(_a, &VlcPlayer::vlcOptionsChanged, 14))
            return;
    }
    if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 8:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QQuickItem* >(); break;
        }
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<QString*>(_v) = _t->source(); break;
        case 1: *reinterpret_cast<int*>(_v) = _t->state(); break;
        case 2: *reinterpret_cast<float*>(_v) = _t->position(); break;
        case 3: *reinterpret_cast<int*>(_v) = _t->time(); break;
        case 4: *reinterpret_cast<int*>(_v) = _t->length(); break;
        case 5: *reinterpret_cast<float*>(_v) = _t->volume(); break;
        case 6: *reinterpret_cast<bool*>(_v) = _t->muted(); break;
        case 7: *reinterpret_cast<QString*>(_v) = _t->errorMessage(); break;
        case 8: *reinterpret_cast<QQuickItem**>(_v) = _t->videoOutput(); break;
        case 9: *reinterpret_cast<QStringList*>(_v) = _t->vlcOptions(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setSource(*reinterpret_cast<QString*>(_v)); break;
        case 2: _t->setPosition(*reinterpret_cast<float*>(_v)); break;
        case 3: _t->setTime(*reinterpret_cast<int*>(_v)); break;
        case 5: _t->setVolume(*reinterpret_cast<float*>(_v)); break;
        case 6: _t->setMuted(*reinterpret_cast<bool*>(_v)); break;
        case 8: _t->setVideoOutput(*reinterpret_cast<QQuickItem**>(_v)); break;
        case 9: _t->setVlcOptions(*reinterpret_cast<QStringList*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *VlcPlayer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *VlcPlayer::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9VlcPlayerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int VlcPlayer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 26)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 26;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 26)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 26;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    }
    return _id;
}

// SIGNAL 0
void VlcPlayer::sourceChanged(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 0, nullptr, _t1);
}

// SIGNAL 1
void VlcPlayer::stateChanged(int _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 1, nullptr, _t1);
}

// SIGNAL 2
void VlcPlayer::positionChanged(float _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 2, nullptr, _t1);
}

// SIGNAL 3
void VlcPlayer::timeChanged(int _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 3, nullptr, _t1);
}

// SIGNAL 4
void VlcPlayer::lengthChanged(int _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 4, nullptr, _t1);
}

// SIGNAL 5
void VlcPlayer::volumeChanged(float _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 5, nullptr, _t1);
}

// SIGNAL 6
void VlcPlayer::mutedChanged(bool _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 6, nullptr, _t1);
}

// SIGNAL 7
void VlcPlayer::errorMessageChanged(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 7, nullptr, _t1);
}

// SIGNAL 8
void VlcPlayer::videoOutputChanged(QQuickItem * _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 8, nullptr, _t1);
}

// SIGNAL 9
void VlcPlayer::playing()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}

// SIGNAL 10
void VlcPlayer::paused()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}

// SIGNAL 11
void VlcPlayer::stopped()
{
    QMetaObject::activate(this, &staticMetaObject, 11, nullptr);
}

// SIGNAL 12
void VlcPlayer::ended()
{
    QMetaObject::activate(this, &staticMetaObject, 12, nullptr);
}

// SIGNAL 13
void VlcPlayer::error()
{
    QMetaObject::activate(this, &staticMetaObject, 13, nullptr);
}

// SIGNAL 14
void VlcPlayer::vlcOptionsChanged(const QStringList & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 14, nullptr, _t1);
}
QT_WARNING_POP
