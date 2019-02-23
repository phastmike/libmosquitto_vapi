using Mosquitto;

public void my_message_callback (Client client, void *userdata, Message message) {
    if (message.payloadlen != 0) {
        print ("%s %s\n", message.topic, message.payload);
    } else {
        print ("%s (null)\n", message.topic);
    }

    /* Test message_copy */
    /*
    var dst = Mosquitto.Message ();
    var r = Mosquitto.Message.copy (dst, message);
    print ("%s %s %s\n", Mosquitto.strerror (r), dst.topic, (string?) dst.payload);

    dst.free_contents ();
    */
} 

public void my_connect_callback (Client client, void *userdata, int result) {
    if(result == 0){
        /* Subscribe to broker information topics on successful connect. */
        client.subscribe(null, "$SYS/#", 2);
    }else{
        print ("Connect failed: %s\n", Mosquitto.strerror (result));
    }
}


public void my_subscribe_callback (Client client, void *userdata, int mid, int qos_count, int[] granted_qos) {
    int i;

    print ("Subscribed (mid: %d): %d", mid, granted_qos[0]);
    for(i=1; i<qos_count; i++){
        print (", %d", granted_qos[i]);
    }
    print ("\n");
}


public void my_log_callback (Client client, void *userdata, int level, string str) {
    /* Pring all log messages regardless of level. */
    print ("my_log_callback: %s\n", str);
}


public int main (string[] args) {
    int port = 1883;
    int keepalive = 60;
    bool clean_session = true;
    string host = "test.mosquitto.org";
    
    Mosquitto.init ();

    var client = new Client (null, clean_session, null);
    client.log_callback_set (my_log_callback);
    client.connect_callback_set (my_connect_callback);
    client.message_callback_set (my_message_callback);
    client.subscribe_callback_set (my_subscribe_callback);

    if (client.connect (host, port, keepalive) != 0) {
        print ("Unable to connect.\n");
        return 1;
    }

    client.loop_forever (-1, 1);

    Mosquitto.cleanup ();
    return 0;
}

