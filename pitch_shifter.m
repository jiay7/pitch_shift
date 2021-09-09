function new_data = pitch_shifter( data ,sr, ratio )
%功能：对于输入的音频数据变换频率并输出
%       data为输入音频数据 
%       sr为输入音频的采样率
%       ratio为输入频率变换因子向量，ratio>1表示降低频率，ratio<1表示升高频率
%       new_data为输出变换后的音频数据

win = hamming(128); 
len_win = length(win);
win = [win(len_win/2+1:end);win(1:len_win/2)];%上下翻转hamming窗，为降低连接处高频成分所用
per_time = 0.1;%每一小段音频持续时间(s)

total_time = length(ratio)*per_time;%输出音频data长度
temp = 0;%当前变换数据位置比例初始化为0
per_sr = per_time*sr;%每一段音频的数据长度
time = floor(total_time/per_time);%总的小段音频数量
new_data=zeros(floor(sr*total_time),1);%初始化输出音频数据

for i = [1:time]
    temp_data = resample(data,floor(ratio(i)*sr),sr);%重采样
    temp_data1 = [temp_data;temp_data];%重复重采样数据，防止数据位置所占比例过高
    %平滑连接处
    temp_data1(length(temp_data)-100:length(temp_data)+100) = smooth(temp_data1(length(temp_data)-100:length(temp_data)+100));
    %使用变换后的hamming窗压低高频成分
    temp_data1(length(temp_data)-63:length(temp_data)+64) = temp_data1(length(temp_data)-63:length(temp_data)+64).*win;
    
    new_data((i-1)*per_sr+1:per_sr*i) = temp_data1(ceil(length(temp_data)*temp)+1:per_sr+ceil(length(temp_data)*temp));
    if i ~=1
        new_data((i-1)*per_sr-100:(i-1)*per_sr+100) = smooth(new_data((i-1)*per_sr-100:(i-1)*per_sr+100),'sgolay');
        new_data((i-1)*per_sr-len_win/2+1:(i-1)*per_sr+len_win/2) = new_data((i-1)*per_sr-len_win/2+1:(i-1)*per_sr+len_win/2).*win;
    end
    %更新当前位置所占比例，注：不能大于1
      temp = (per_sr+length(temp_data)*temp)/length(temp_data) - floor((per_sr+length(temp_data)*temp)/length(temp_data));
end

end

