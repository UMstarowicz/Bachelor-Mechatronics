clear all;
clc;
close all;

%% Open video file
video = vision.VideoFileReader('VID_20231122_231446.avi');
player = vision.DeployableVideoPlayer('Location', [10, 100]);

while playControls
    while ~isDone(video)
        step(player, step(video));
    end
    reset(video);
end
delete(player);

%% Detect the ball in the video

fgDetector = vision.ForegroundDetector('NumTrainingFrames', 10, 'InitialVariance', 0.05);
blobAnalyzer = vision.BlobAnalysis('AreaOutputPort', true, 'MinimumBlobArea', 70, 'CentroidOutputPort', true);
player = vision.DeployableVideoPlayer('Location', [10, 100]);
fgPlayer = vision.DeployableVideoPlayer('Location', player.Location); %nie wiem co jest po L
reset(video);

while playControls
    while ~isDone(video)
        image = step(video);
        I = rgb2gray(image);
        fgMask = step(fgDetector, I);
        fgMask = bwareaopen(fgMask, 25);
        [~, detection] = step(blobAnalyzer, fgMask);
        step(fgPlayer,fgMask);
        if ~isempty(detection)
            position = detection(1,:);
            position(:,3) = 10;
            combinedImage = insertObjectAnnotation(image, 'circle', position,'Ball');
            step(player, combinedImage);
        else
            step(player, image);
        end
step(fgPlayer, fgMask);
    end
    reset(video);
end
delete(player);
delete(player);

%% Track the ball in the video
%Pick kalman filter parameters for use with configureKalman

kalmanFilter = [];
if 1
    motionModel = 'ConstatntAcceleration';
    initialEstimateError = 100*ones(1,3);
    motionNoise = [25, 10, 10];
    measurementNoise = 25;

else
    motionModel = 'ConstantVelocity';
    initialEstimateError = 1000*ones(1,2);
    motionNoise = [25, 10];
    measurementNoise = 25;
end

%% Set up loop for tracking
player = vision.DeployableVideoPlayer('Location', [10, 100]);
fgPlayer = vision.DeployableVideoPlayer('Location', player.Location); %nie wiem co jest po L
isTrackInitialized = false;
isObjectDetected = false;

reset(video);
while playControls
    while ~isDone(video)
        image = step(video);
        I = rgb2gray(image);

        %detect the ball
        fgMask = step(fgDetector,I);
        fgMask = bwareaopen(fgMask, 25);
        [~, detection] = step(blobAnalyzer, fgMask);
        step(fgPlayer, fgMask);

        %track the ball
        if size(detection,1) > 0
            detection = dection(1,:);
            isObjectDetected = true;
        else
            isObjectDetected = false;
        end

        if ~isTrackInitialized
            if isObjectDetected
                kalmanFilter = configureKalmanFilter(motionModel, detection, initialEstimateError, motionNoise, measurementNoise);
                isTrackInitialized = true;
                trackedLocation = correct(kalmanFilter, detection);
                label = 'Initial';
                position = [detection 10];
                combinedImage = inserObjectAnnotation(image, 'circle', position, label);
                step(player, combinedImage);
            else
                trackedLocation = [];
                label = '';
                step(player, image);
            end
        else
            if isObjectDetected
                predict(kalmanFilter);
                trackedLocation = correct(kalmanFilter, detection);
                label = 'Corrected';
            else %ball is missing
                trackedLocation = predict(kalmanFilter);
                label = 'Predicted';
            end
            position = [trackedLocation 10];
            combinedImage = insertObjectAnnotation(image, 'circle', position, label);
            step(player, combinedImage);
        end
        step(fgPlayer, fgMask);
    end
    reset(video);
    isTrackInitialized = false;
    isObjectDetected = false;
end
delete(player);
delete(fgPlayer);
%%
release(video);

