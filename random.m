qpskmod = comm.QPSKModulator('BitInput',true);
d = randi([0 1],1000,3);
for d=d
    x = qpskmod(d);
end
size(x)
for d=[1 2;3 4]
    d
end
a=[]
a=[a [1;2]]
a=[a [1;2]]