#ifndef NETWORK_H
#define NETWORK_H

#define CLIENT_QUEUED 1
#define CLIENT_NOT_QUEUED 0

#define AUDIO_INPUT_REQUEST 1
#define AUDIO_OUTPUT_REQUEST 2

// Control commands
#define CONTROL_GET_COMMAND 3
#define CONTROL_SET_COMMAND 4

// Response codes
#define RESPONSE_OK 200
#define RESPONSE_ERROR 400
#define RESPONSE_UNKNOWN_VARIABLE 404

// Functions
void update_socket_paths_from_config();
char* get_variable_value(const char* variable_name);
int set_variable_value(const char* variable_name, const char* value);

#endif // NETWORK_H
