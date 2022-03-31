%% 
% *Execute a command*
% 
% # Try writing a command in command window 
% # Assign a variable : Assign a constant to variable 
% # Assignment operator : The operator(=) can be used to assign value
% 
% 

x=5
y=x
%% 
% *Workspace in matlab*
% 
% It contains the current variables that are stored 
% 
% 
% 
% *Semicolon* 
% 
% Using a semicolon after any operation does not print the output 
% 
% *Recall previous commands*
% 
% By using arrow keys we can also refer to previous commands entered in command 
% window
% 
% 
% 
% *Enter just a variable*
% 
% writing a varibale and simply pressing enter prints its value
% 
% 
% 
% *Naming a Variable*
% 
% You can name your Matlab Variables anything start wih a letter and contain 
% only letters , numbers and underscores (_)
%%
y=6;
y
%% 
% *Save the workspace to a mat file* 
% 
% We can save the current workspace to be loaded again in future . This saves 
% the data to .mat file in the current directory .
% 
% Simply,
% 
% save filename
% 
% load filename
% 
% 
% 
% Side tip : To remove previous clear the command window use "clc"
%%
save basic.mat
load basic.mat
%% 
% *Using built in functions*
% 
% Matlab has a lot of built in functions that can be used to perform operations 
% 
% abs , sin , cos , sqrt 
% 
% 
% 
% While performing an operation you might have noticed that the output shows 
% only 4 decimal digits to increase/decrease the accuracy of operations we use 
% 
%  format long , format short
% 
% 
%%
abs(-6)
sqrt(-6)
format long 
sqrt(-6)
%% 
% *Array *
% 
% Collection of data is called an array . It has two constituents rows and 
% columns
% 
% array=[(row1,col1) (row1,col2) (row1,col3);
% 
%             (row2,col1) (row2,col2) (row2,col3);
% 
%             (row2,col1) (row3,col2) (row3,col3)]
% 
% A column array of size [rows cols]=[1 2]
% 
% x=[1 2] 
% 
% To make rows semicolon is used.[rows cols]=[2 1]
% 
% x=[1;2]
% 
% Example
% 
% x = [3 4 5;6 7 8]
% 
% 
%%
x=[1 2]
x=[1;2]
x=[3 4 5;6 7 8]
%% 
% *Vector*
% 
% A *vector* is a list of numbers (can be in a row or column)
% 
% Evently Spaced vectors
% 
% To make a list of vectors we use a *first:last* , by default the difference 
% is 1.
% 
% y=5:8
% 
% We can also use the following format *first:difference:last*
% 
% x=20:2:26
% 
% 
% 
% If we know the number of elements we require we can use the following command 
% *linspace(_first_,_last_,_number_of_elements_)*
% 
% linspace(1,10,100)
% 
% 
% 
% Exercise : If we want to make a 100 elements between 1 and 2*pi what command 
% should we use
% 
% Note : The output of these commands results in a column vector , to convert 
% it into a row vector we can do Transpose by
% 
% *x=x’*
% 
% Side tip: If you dont assign a variable to the output it is stored in ans

y=5:8
x=20:2:26
linspace(1,10,100)
x=x'
%% 
% *Array Creation Functions*
% 
% Some arrays which are widely used during calculations have pre defined 
% functions
% 
% Make a 2x2 random number array between 0 and 1
% 
% x = rand(2)
% 
% Make a 2x3 random number array between 0 and 1
% 
% x = rand(2,3)
% 
% 
% 
% Make an array of ones 
% 
% ones(2,3)
% 
% Similarily try  zeros,eye
% 
% Tip : size , can be used to get the size of an array
%%
x=rand(2)
x=rand(2,3)
size(x)
%% 
% *Indexing an array*
% 
% To refer to an element in array indexing is used 
% 
% Index an element : x(1)
% 
% For a 2D it reads column wise i.e for a 2x3 array
% 
% 1 3 5
% 
% 2 4 6
% 
% Index series of element : x(2:4) , elemts from index 2 to 4 are given as 
% output
% 
% Index 2D array : x(1,:) , all elements in row=1 and all columns are given 
% as output 
% 
% 
% 
% So, x(idx) , x(row,col)
% 
% Indexing the last element : z=x(end,2) or x(end-1,2)
% 
% Exercise : Try extracting the non consecutive numbers in array
%%
x(1)
x(2:4)
x(1,:)
z=x(end,2)
y(1)=x(end,2)
%% 
% *Arithmetic Operations*
% 
% x=[1 2 3 4]
% 
% y=x+2
% 
% z=x+y
% 
% 
% 
% basic statistic max,sqrt,matrix multiplication are all applicable on arrays
% 
% For Matrix multiplication , z=[3 4] *[10;20]
% 
% For element wise multiplication , z=[3 4] .*[10 20]
% 
% 
% 
% The dot before a mathematical opration implies element wise operation
% 
% Example: x=x.^2
% 
%                 x=x^2
%%
x=[1 2 3 4]
y=x+2
z=x+y
z=[3 4] *[10;20]
z=[3 4].*[10 20]
%% 
% *Function calls*
% 
% x=[1 2 3 4 5]
% 
% [xrow,xcol] = size(x)
% 
% The output of size is assigned to xrow and xcol variables
% 
% [xMax,idx] = max(x)
% 
% Use tilde to ignore specific values
% 
% [~,ivMax] = max(x)
% 
% 
% 
% Exercise : Check the documentation for creating a custom function <https://in.mathworks.com/help/matlab/ref/function.html 
% https://in.mathworks.com/help/matlab/ref/function.html> 
%%
x=[1 2 3 4 5]
[xrow,xcol] = size(x)
[xMax,idx] = max(x)
[~,ivMax] = max(x)
%% 
% *Obtaing Help from matlab documentation*
% 
% We cant remember everything so matlab has offline documentation of everything 
% that is required . Click on Help or search in documentation.
% 
% 
% 
% Or Help and search for function in command window
% 
% doc randi
%%
doc randi
%% 
% *Plotting *
% 
% It is important to plot the data we have for better visualization
% 
% x are the points on x axis
% 
% y are the points on y axis
% 
% *plot(x,y)*
% 
% *plot(x,y,"r--o")*
% 
% The command above plots a red (r) dashed (--) line with a circle (o) as 
% a marker. You can learn more about the symbols available in the documentation 
% for <https://www.mathworks.com/help/matlab/ref/linespec.html Line Specification>.
% 
% *hold on *command to hold the previous plot while you add another line
% 
% Check out : <https://in.mathworks.com/products/matlab/plot-gallery.html 
% https://in.mathworks.com/products/matlab/plot-gallery.html> 
% 
% Some more commands .
% 
% xlabel('-pi/2 < x < pi/2') 
% 
% ylabel('Sine and Cosine Values') 
% 
% legend(["cos" "sin"])
% 
% 
%%
x=-pi/2:0.1:pi/2
y=cos(x)
z=sin(x)
plot(x,y,"b--o")
hold on
plot(x,z,"r--o")
hold off
xlabel('-pi/2<x<pi/2')
ylabel('sine and cosine values')
legend(["cos" "sin"])
%% 
% <https://www.mathworks.com/help/matlab/matlab_prog/array-comparison-with-relational-operators.html 
% Relational operators>, such as >, <, ==, and ~= perform comparisons between 
% two values. The outcome of a comparison for equality or inequality is either 
% 1 (true) or 0 (false).
% 
% 
% 
% You can use a logical array as an array index, in which case MATLAB extracts 
% the array elements where the index is true.
% 
% x(x<0)
% 
% 
% 
% To reassign value
% 
% x(x==0) = 1
%%
x=-pi/2:0.1:pi/2
x<0
x(x<0)
%% 
% IF/ELSE
% 
% Conditional statements are required to skip a section of code if some contion 
% is true or false
% 
% 
% 
% xxx
% 
% if condition
% 
%       xxx
% 
% elseif condition 
% 
%     xxx
% 
% else
% 
% xxxxxx
% 
% end
% 
% xxx
% 
% Tip: No need to worry about indentation but it is good to have
% 
% 
%%
if(1<5)
disp("1<5")
elseif(1>5)
disp("1>5")
else
disp("1==5")
end
%% 
% LOOP
% 
% looops are used if we want ot execute same command again and again
% 
% 
% 
% for x=1:5
% 
% xxxxx
% 
% end
% 
% 
%%
z=[]
for x=1:5
    z=[z x];
end
z