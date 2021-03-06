%SLR using PCA- base features
n=input('Enter no. of images for training: ');
L=input('Enter no. of dominant Eigen values to keep: ');
M=100; N=90; %Required image dimesnions
X=zeros(n,256); %Initialize dataset matrix for the histogram[X]
T=zeros (n,L); %Initialize Transformed dataset [T] in PCA space
for count=1:n
    I=imread(sprintf('%d.jpg',count));  %Read input image
    I=rgb2gray(I);
    I=imresize(I,[M,N]);  
    img=reshape(I,[1,M*N]); %Reshaping images as 1D vector
    X(count,:)=imhist(I,256); %Generating histogram of all resized images
end
Xb=X;
m=mean(X); %Mean of histogram of all images
for i=1:n
    X(i,:)=X(i,:)-m; %Subtracting mean of histogram from each histogram of 1D image
end
Q=(X'*X)/(n-1); %Finding covariance matrix
[Evecm, Evalm]=eig(Q);  %Getting Eigen values and Eigen vectors of COV matrix [Q]
Eval=diag(Evalm); %Extracting all Eigen values
[Evalsorted,Index]=sort(Eval, 'descend'); %Sorting Eigen values
Evecsorted=Evecm(:,Index);
Ppca=Evecsorted(:,1:L); %Reduced Transformation matrix [Ppca]
for i=1:n
    T(i,:)=(Xb(i,:)-m)*Ppca; %Projecting each histogram to PCA space
end