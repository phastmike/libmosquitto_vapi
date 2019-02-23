/* Test libmosquitto vapi file */

using Mosquitto;

public void test_version () {
    int major, minor, revision;
    var version = Mosquitto.version (out major, out minor, out revision);
    print ("* Test version:\n");
    print ("libmosquito version: %d.%d.%d (%d)\n", major, minor, revision, version);
}

public void test_error () {
    print ("* Test error:\n");
    print ("Error %d: [%s]\n", Mosquitto.Error.CONN_PENDING, Mosquitto.strerror (Mosquitto.Error.CONN_PENDING));
}

public void test_connack () {
    print ("* Test connack:\n");
    print ("Connack 0: [%s]\n", connack_string (0));
}

public void test_option () {
    print ("* Test options enum:\n");
    print ("PROTOCOL_VERSION: %d\n", Mosquitto.Options.PROTOCOL_VERSION);
}

public void test_log () {
    print ("* Test log enum:\n");
    print ("WARNING: 0x%x\n", Mosquitto.Log.WARNING);
    print ("ALL: 0x%x\n", Mosquitto.Log.ALL);
}

public void main () {
    Mosquitto.init ();
    
    test_version ();
    test_error (); 
    test_connack ();
    test_option ();
    test_log ();

    Mosquitto.cleanup ();
}
