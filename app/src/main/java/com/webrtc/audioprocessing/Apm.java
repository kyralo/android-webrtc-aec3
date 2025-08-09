package com.webrtc.audioprocessing;

/**
 * Created by sino on 2016-03-14.
 */
public class Apm {
    static {
        System.loadLibrary("webrtc_aec3");
    }

    public Apm() throws Exception {
        if(!nativeCreateApmInstance()){
            throw new Exception("create apm failed!");
        }
        _init = true;
    }


    public void close() {
        if(_init){
            nativeFreeApmInstance();
            _init = false;
        }
    }

    //
    public int ProcessCaptureStream(short[] nearEnd, int offset) { // 16K, 16bits, mono， 10ms
        return ProcessStream(nearEnd, offset);
    }

    //ProcessRenderStream: It is only necessary to provide this if echo processing is enabled, as the
    // reverse stream forms the echo reference signal. It is recommended, but not
    // necessary, to provide if gain control is enabled.
    // may modify |farEnd| if intelligibility is enabled.

    public int ProcessRenderStream(short[] farEnd, int offset)
    { // 16K, 16bits, mono， 10ms
        return ProcessReverseStream(farEnd, offset);
    }
//    public int SetStreamDelay(int delay_ms){ return set_stream_delay_ms(delay_ms);  }

    @Override
    protected void finalize() throws Throwable {
        super.finalize();
        close();
    }

    private native boolean nativeCreateApmInstance();
    private native void nativeFreeApmInstance();

    private native int ProcessStream(short[] nearEnd, int offset); //Local data// 16K, 16Bits, 10ms
    private native int ProcessReverseStream(short[] farEnd, int offset); // Remote data // 16K, 16Bits, 10ms
//    private native int set_stream_delay_ms(int delay);

    private boolean _init = false;
    private long objData; // do not modify it.
}
