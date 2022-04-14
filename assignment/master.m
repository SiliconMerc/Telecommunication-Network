%Name : Pranav Mittal
%Branch : Electronics Engineering
%Roll Number : 19095076
%%
t=1:0.1:10;
users=2 %number of users on the channel
%input and output transmission source / sink for each user
readPath=["cat.mp4" "cat.mp4"];
eof=false
for user=1:users
    %write video
    writePath=strcat('cats',num2str(user),'.avi');
    v(user) = VideoWriter(writePath);
    v(user).FrameRate = 1;
    open(v(user));
end
%modulation schemes and channel characteristics
errorRate = comm.ErrorRate;   
c = [1 1i -1 -1i];
modulator1=comm.BPSKModulator;
modulator2=comm.GeneralQAMModulator(c);
demodulator1= comm.BPSKDemodulator;
demodulator2=comm.GeneralQAMDemodulator('Constellation',c,'BitOutput',true);
%%
% Use this for th polynomial:
% 'z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1'

poly='z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1';
crcgenerator=comm.CRCGenerator(poly);
% 1.2) After generating a CRCGenerator above, create a CRCDetector Object for
% error detection here.
crcdetector=comm.CRCDetector(poly);

%initilization of gui waitbar
f = waitbar(0,'Please wait...');

for time = t
    for user=1:users
        %get video frame from file
        vidObj = VideoReader(readPath(user));
        vidObj.CurrentTime=time;
        frame = readFrame(vidObj);
        %imshow(frame);
        frame=imresize(frame,[64 64]);
        % imshow(frame);
        size(frame);
        image= frame;
        % while(hasFrame(vidObj))
        % %    vidObj.CurrentTime=time
        %    frame = readFrame(vidObj);
        %    imresize(frame,[64 64])
        %    imshow(frame);
        %    title(sprintf('Current Time = %.3f sec', vidObj.CurrentTime));
        %    pause(1/vidObj.FrameRate);

        %serialize image data
        data=image(:);
        %convert data to bits
        b = de2bi(data,'left-msb',8)';%converting to binary(column vector) where eight bits mean a number
        bits=b(:);
        serialData=double(bits);
        %apply crc to serialData
        %apply CRC. Use the object generated above
        txData=crcgenerator(serialData);
        
        if user==2 
            bits=reshape(txData,2,[])';
            transmittedData = bi2de(bits,'left-msb');
        else
            transmittedData=txData;
        end
        
%         if user ==1
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%channel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Modulation=eval(strcat('modulator',num2str(user)));
            modData = Modulation(transmittedData);
            
            %figure(1);
            %scatterplot(modData);
            rxSig = awgn(modData,10);                % Pass through AWGN
            Demodulation=eval(strcat('demodulator',num2str(user)));
            rxData = Demodulation(rxSig);       % Demodulate
            %figure(2);
            %scatterplot(rxData);
            if user==2
                errorStats = errorRate(txData,rxData); % Collect error stats
    %             txData(1:10)
    %             rxData(1:10)
                %fprintf('Error rate = %f\nNumber of errors = %d\n',errorStats(1), errorStats(2));
            end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%transmission%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Check if error occured by using comm.CRCDetector
        [serialReceived,err]=crcdetector(rxData);
        if err==1
            %fprintf('Error at %f\n',time);
        end
        %convert bits to group of 8
        bits=reshape(serialReceived,8,[])';

        %converting bits to image value
        data = bi2de(bits,'left-msb')';%converting to binary(column vector) where eight bits mean a number

        %making the image array
        image=reshape(image,64,64,3);

        % time=1:0.1:10;
        % path="cat.mp4";
        % vidObj = VideoReader(path);
        
        %writing the video output received
        if eof
            close(v(user));
        else
        % for i = time
        % vidObj.CurrentTime=i
        % frame = readFrame(vidObj);
        %imshow(frame);
        % frame=imresize(frame,[64 64]);
        % imshow(frame);
        % size(frame);
            frame= im2frame(image);
            writeVideo(v(user),frame);
        end
    end
    waitbar(time/t(end),f,sprintf('Processing %f / %f , Error rate : %f ',time,t(end),errorStats(1)));
end
close(v(1));
close(v(2));
close(f);