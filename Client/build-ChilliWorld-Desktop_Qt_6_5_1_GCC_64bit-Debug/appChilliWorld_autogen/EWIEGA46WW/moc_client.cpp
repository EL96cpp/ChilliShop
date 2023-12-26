/****************************************************************************
** Meta object code from reading C++ file 'client.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Customer/client.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'client.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.5.1. It"
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

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSClientENDCLASS_t {};
static constexpr auto qt_meta_stringdata_CLASSClientENDCLASS = QtMocHelpers::stringData(
    "Client",
    "addSauceProductToModel",
    "",
    "id",
    "name",
    "price",
    "scoville",
    "text_description",
    "volume",
    "peppers",
    "addSeasoningProductToModel",
    "weight",
    "addSeedsProductToModel",
    "number_of_seeds",
    "registerSuccess",
    "registerError",
    "error_description",
    "loginSuccess",
    "phone_number",
    "loginError",
    "onLogin",
    "password",
    "onRegister",
    "onMakeOrder",
    "order_data",
    "onReadyRead",
    "onChangeName",
    "new_name"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSClientENDCLASS_t {
    uint offsetsAndSizes[56];
    char stringdata0[7];
    char stringdata1[23];
    char stringdata2[1];
    char stringdata3[3];
    char stringdata4[5];
    char stringdata5[6];
    char stringdata6[9];
    char stringdata7[17];
    char stringdata8[7];
    char stringdata9[8];
    char stringdata10[27];
    char stringdata11[7];
    char stringdata12[23];
    char stringdata13[16];
    char stringdata14[16];
    char stringdata15[14];
    char stringdata16[18];
    char stringdata17[13];
    char stringdata18[13];
    char stringdata19[11];
    char stringdata20[8];
    char stringdata21[9];
    char stringdata22[11];
    char stringdata23[12];
    char stringdata24[11];
    char stringdata25[12];
    char stringdata26[13];
    char stringdata27[9];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSClientENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSClientENDCLASS_t qt_meta_stringdata_CLASSClientENDCLASS = {
    {
        QT_MOC_LITERAL(0, 6),  // "Client"
        QT_MOC_LITERAL(7, 22),  // "addSauceProductToModel"
        QT_MOC_LITERAL(30, 0),  // ""
        QT_MOC_LITERAL(31, 2),  // "id"
        QT_MOC_LITERAL(34, 4),  // "name"
        QT_MOC_LITERAL(39, 5),  // "price"
        QT_MOC_LITERAL(45, 8),  // "scoville"
        QT_MOC_LITERAL(54, 16),  // "text_description"
        QT_MOC_LITERAL(71, 6),  // "volume"
        QT_MOC_LITERAL(78, 7),  // "peppers"
        QT_MOC_LITERAL(86, 26),  // "addSeasoningProductToModel"
        QT_MOC_LITERAL(113, 6),  // "weight"
        QT_MOC_LITERAL(120, 22),  // "addSeedsProductToModel"
        QT_MOC_LITERAL(143, 15),  // "number_of_seeds"
        QT_MOC_LITERAL(159, 15),  // "registerSuccess"
        QT_MOC_LITERAL(175, 13),  // "registerError"
        QT_MOC_LITERAL(189, 17),  // "error_description"
        QT_MOC_LITERAL(207, 12),  // "loginSuccess"
        QT_MOC_LITERAL(220, 12),  // "phone_number"
        QT_MOC_LITERAL(233, 10),  // "loginError"
        QT_MOC_LITERAL(244, 7),  // "onLogin"
        QT_MOC_LITERAL(252, 8),  // "password"
        QT_MOC_LITERAL(261, 10),  // "onRegister"
        QT_MOC_LITERAL(272, 11),  // "onMakeOrder"
        QT_MOC_LITERAL(284, 10),  // "order_data"
        QT_MOC_LITERAL(295, 11),  // "onReadyRead"
        QT_MOC_LITERAL(307, 12),  // "onChangeName"
        QT_MOC_LITERAL(320, 8)   // "new_name"
    },
    "Client",
    "addSauceProductToModel",
    "",
    "id",
    "name",
    "price",
    "scoville",
    "text_description",
    "volume",
    "peppers",
    "addSeasoningProductToModel",
    "weight",
    "addSeedsProductToModel",
    "number_of_seeds",
    "registerSuccess",
    "registerError",
    "error_description",
    "loginSuccess",
    "phone_number",
    "loginError",
    "onLogin",
    "password",
    "onRegister",
    "onMakeOrder",
    "order_data",
    "onReadyRead",
    "onChangeName",
    "new_name"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSClientENDCLASS[] = {

 // content:
      11,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    7,   86,    2, 0x06,    1 /* Public */,
      10,    7,  101,    2, 0x06,    9 /* Public */,
      12,    7,  116,    2, 0x06,   17 /* Public */,
      14,    0,  131,    2, 0x06,   25 /* Public */,
      15,    1,  132,    2, 0x06,   26 /* Public */,
      17,    2,  135,    2, 0x06,   28 /* Public */,
      19,    1,  140,    2, 0x06,   31 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
      20,    2,  143,    2, 0x0a,   33 /* Public */,
      22,    3,  148,    2, 0x0a,   36 /* Public */,
      23,    2,  155,    2, 0x0a,   40 /* Public */,
      25,    0,  160,    2, 0x0a,   43 /* Public */,
      26,    1,  161,    2, 0x0a,   44 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Int, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::QString, QMetaType::Double, QMetaType::QJsonArray,    3,    4,    5,    6,    7,    8,    9,
    QMetaType::Void, QMetaType::Int, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::QString, QMetaType::Int, QMetaType::QJsonArray,    3,    4,    5,    6,    7,   11,    9,
    QMetaType::Void, QMetaType::Int, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::QString, QMetaType::Int, QMetaType::QJsonArray,    3,    4,    5,    6,    7,   13,    9,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   16,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   18,    4,
    QMetaType::Void, QMetaType::QString,   16,

 // slots: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   18,   21,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,   18,   21,    4,
    QMetaType::Void, QMetaType::QString, QMetaType::QJsonObject,   18,   24,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   27,

       0        // eod
};

Q_CONSTINIT const QMetaObject Client::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSClientENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSClientENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSClientENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<Client, std::true_type>,
        // method 'addSauceProductToModel'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const double &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QJsonArray &, std::false_type>,
        // method 'addSeasoningProductToModel'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QJsonArray &, std::false_type>,
        // method 'addSeedsProductToModel'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const int &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QJsonArray &, std::false_type>,
        // method 'registerSuccess'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'registerError'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'loginSuccess'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'loginError'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'onLogin'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'onRegister'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'onMakeOrder'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QJsonObject &, std::false_type>,
        // method 'onReadyRead'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'onChangeName'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>
    >,
    nullptr
} };

void Client::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Client *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->addSauceProductToModel((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[6])),(*reinterpret_cast< std::add_pointer_t<QJsonArray>>(_a[7]))); break;
        case 1: _t->addSeasoningProductToModel((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[6])),(*reinterpret_cast< std::add_pointer_t<QJsonArray>>(_a[7]))); break;
        case 2: _t->addSeedsProductToModel((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[6])),(*reinterpret_cast< std::add_pointer_t<QJsonArray>>(_a[7]))); break;
        case 3: _t->registerSuccess(); break;
        case 4: _t->registerError((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 5: _t->loginSuccess((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 6: _t->loginError((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 7: _t->onLogin((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 8: _t->onRegister((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 9: _t->onMakeOrder((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2]))); break;
        case 10: _t->onReadyRead(); break;
        case 11: _t->onChangeName((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Client::*)(const int & , const QString & , const int & , const int & , const QString & , const double & , const QJsonArray & );
            if (_t _q_method = &Client::addSauceProductToModel; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Client::*)(const int & , const QString & , const int & , const int & , const QString & , const int & , const QJsonArray & );
            if (_t _q_method = &Client::addSeasoningProductToModel; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Client::*)(const int & , const QString & , const int & , const int & , const QString & , const int & , const QJsonArray & );
            if (_t _q_method = &Client::addSeedsProductToModel; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Client::*)();
            if (_t _q_method = &Client::registerSuccess; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Client::*)(const QString & );
            if (_t _q_method = &Client::registerError; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (Client::*)(const QString & , const QString & );
            if (_t _q_method = &Client::loginSuccess; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (Client::*)(const QString & );
            if (_t _q_method = &Client::loginError; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 6;
                return;
            }
        }
    }
}

const QMetaObject *Client::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Client::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSClientENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Client::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 12)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 12;
    }
    return _id;
}

// SIGNAL 0
void Client::addSauceProductToModel(const int & _t1, const QString & _t2, const int & _t3, const int & _t4, const QString & _t5, const double & _t6, const QJsonArray & _t7)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t5))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t6))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t7))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Client::addSeasoningProductToModel(const int & _t1, const QString & _t2, const int & _t3, const int & _t4, const QString & _t5, const int & _t6, const QJsonArray & _t7)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t5))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t6))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t7))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void Client::addSeedsProductToModel(const int & _t1, const QString & _t2, const int & _t3, const int & _t4, const QString & _t5, const int & _t6, const QJsonArray & _t7)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t5))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t6))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t7))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Client::registerSuccess()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void Client::registerError(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void Client::loginSuccess(const QString & _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void Client::loginError(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}
QT_WARNING_POP
