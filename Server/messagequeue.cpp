#include "messagequeue.h"

MessageQueue::MessageQueue()
{

}

void MessageQueue::enqueue(Message *message)
{
    QMutexLocker locker(&mutex);
    messages.enqueue(message);
}

Message *MessageQueue::dequeue()
{
    QMutexLocker locker(&mutex);
    return messages.dequeue();
}
