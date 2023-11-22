#include "authorizationmessage.h"

AuthorizationMessage::AuthorizationMessage(const QString& method, const QString& resource,
                                           const QString& phone_number, const QString& password,
                                           const QString& name) : Message(method, resource),
                                                                  phone_number(phone_number),
                                                                  password(password),
                                                                  name(name){}

QString AuthorizationMessage::getPhoneNumber()
{
    return phone_number;
}

QString AuthorizationMessage::getPassword()
{
    return password;
}

QString AuthorizationMessage::getName()
{
    return name;
}
