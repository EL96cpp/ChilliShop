#include "server.h"

Server::Server() : sql_service(new SqlService(this))
{

}

void Server::incomingConnection(qintptr handle) {

}
