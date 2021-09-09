About the algorithm for pitch_shifter

	This is an algorithm that can be used to frequency-convert the input audio.
	Input parameters include audio data, sample rate and input frequency transform factor vectors. When the input frequency conversion factor is greater than 1, the output audio frequency becomes lower, and when the input frequency conversion factor is less than 1, the output audio frequency becomes higher.
	The output data is the audio data after the conversion frequency
	
	The principle of the algorithm: The input audio data is resampled according to the input frequency conversion factor. Connect each resampled data. Because there are high-frequency components that affect the auditory effect at the joint, we smoothed and windowed the connected data.
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	输出数据为变换频率后的音频数据
	算法的原理：根据输入的频率变换因子对输入音频数据进行重采样。然后将各个重采样的数据连接起来。因为连接处会出现影响听觉效果的高频分量，所以我们在连接处进行了平滑和加窗处理。
	