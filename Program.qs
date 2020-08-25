namespace QuantumRNG {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    

    // @EntryPoint()
    operation GenerateRandomBit() : Result {
        using (q = Qubit()){
            H(q);
            return MResetZ(q);
        }
    }

    operation SampleRandomGenInRange(max : Int) : Int
    {
        mutable output = 0;
        repeat{
            mutable bits = new Result[0];
            for (idxBit in 1..BitSizeI(max)){
                set bits += [GenerateRandomBit()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output <= max);
        return output;    
    }

    @EntryPoint()
    operation SampleRNGCaller() : Int
    {
        let max = 0x10001;
        Message($"Sampleing a Random Number generator using Quantum between 0 to {max} : ");
        return SampleRandomGenInRange(max);
    }
}