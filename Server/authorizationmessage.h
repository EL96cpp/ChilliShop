#ifndef AUTHORIZATIONMESSAGE_H
#define AUTHORIZATIONMESSAGE_H

#include <QString>

#include "message.h"

class AuthorizationMessage : public Message
{
public:
    AuthorizationMessage(const QString& method, const QString& resource,
                         const QString& phone_number, const QString& password,
                         const QString& name = "");

    QString getPhoneNumber();
    QString getPassword();
    QString getName();

private:
    QString phone_number;
    QString password;
    QString name;

};

#endif // AUTHORIZATIONMESSAGE_H
