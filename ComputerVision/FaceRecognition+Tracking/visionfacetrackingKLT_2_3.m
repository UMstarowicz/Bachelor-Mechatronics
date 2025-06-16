
%% Wykrywanie Twarzy
faceDetector = vision.CascadeObjectDetector();

videoFileReader = vision.VideoFileReader('video.avi');
videoFrame = step(videoFileReader);

bbox = step(faceDetector, videoFrame);
faceRegion = imcrop(videoFrame, bbox);

grayFace = rgb2gray(faceRegion);
imgauss = imgaussfilt(grayFace);

points = detectMinEigenFeatures(imgauss);
points = points.Location + double(bbox(1:2));

%% Tracker
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
initialize(pointTracker, double(points), imgaussfilt(rgb2gray(videoFrame)));

videoInfo = info(videoFileReader);
videoPlayer = vision.VideoPlayer('Position', [100 100 ...
    videoInfo.VideoSize(1:2)+30]);

oldPoints = double(points);
meanPoints = mean(oldPoints);
while ~isDone(videoFileReader)

    videoFrame = step(videoFileReader);

    [points, isFound] = step(pointTracker, rgb2gray(videoFrame));
    visiblePoints = points(isFound, :);

    if (size(visiblePoints, 1) > 1.2 * size(oldPoints, 1)) || (size(visiblePoints, 1) < 0.8 * size(oldPoints, 1))

        bbox = step(faceDetector, videoFrame);
        faceRegion = imcrop(videoFrame, bbox);

        grayFace = rgb2gray(faceRegion);
        imgauss = imgaussfilt(grayFace);

        oldPoints = detectMinEigenFeatures(imgauss);
    else

        videoFrame = insertMarker(videoFrame,visiblePoints,'Color','yellow');
        meanPoints = [meanPoints; mean(visiblePoints)];
        videoFrame = insertShape(videoFrame,"line", meanPoints,'Color','blue');
    end
    step(videoPlayer, videoFrame);

    oldPoints = visiblePoints;

    pause(1/30)
end

release(videoFileReader);
release(videoPlayer);
release(pointTracker);
close all;
