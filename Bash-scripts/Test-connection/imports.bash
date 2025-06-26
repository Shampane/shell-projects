network_functions="./Functions/Network"
logging_functions="./Functions/Logging"

source "$network_functions/ping-host.bash"
source "$network_functions/test-port.bash"
source "$network_functions/trace-host.bash"

source "$logging_functions/show-help.bash"
source "$logging_functions/log-error.bash"
source "$logging_functions/log-time-event.bash"
source "$logging_functions/log-message.bash"
