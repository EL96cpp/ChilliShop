#ifndef MESSAGEQUEUE_H
#define MESSAGEQUEUE_H

#include <QDebug>
#include <QQueue>
#include <QMutex>
#include <QMutexLocker>

#include "message.h"

class MessageQueue
{
public:
    MessageQueue();
    void enqueue(Message* message);
    Message *dequeue();

private:
    QQueue<Message*> messages;
    QMutex mutex;

};

#endif // MESSAGEQUEUE_H
