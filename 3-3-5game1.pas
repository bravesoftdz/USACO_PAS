{
ID:kjinxin1
PROG:game1
LANG:PASCAL
}
var
  sum,value:array[0..101] of longint;
  f:array[0..101,0..101] of longint;
  i,j,n:longint;
procedure init;
var
  i,j:longint;
begin
  readln(n);
  for i:= 1 to n do
    begin
      read(value[i]);
      sum[i]:=sum[i-1]+value[i];
    end;
end;
function max(m,n:longint):longint;
begin
  if m>n then exit(m) else exit(n);
end;
function search(i,j:longint):longint;
begin
  if f[i,j]<>-1 then exit(f[i,j]);
  if i=j then exit(value[i]);
  if j-i=1 then
    begin
      if value[i]>value[j] then exit(value[i])
      else exit(value[j]);
    end;
  if f[i,j-1]=-1 then f[i,j-1]:=search(i,j-1);
  if f[i+1,j]=-1 then f[i+1,j]:=search(i+1,j);
  f[i,j]:=max(sum[j]-sum[i]-f[i+1,j]+value[i],sum[j-1]-sum[i-1]-f[i,j-1]+value[j]);
  exit(f[i,j]);
end;
procedure main;
var
  i,j:longint;
begin
  f[1,n]:=search(1,n);
  writeln(f[1,n],' ',sum[n]-f[1,n]);
end;
begin
  assign(input,'game1.in'); reset(input);
  assign(output,'game1.out'); rewrite(output);
  assign(output,'output.txt'); rewrite(output);
  fillchar(sum,sizeof(sum),0);
  fillchar(value,sizeof(value),0);
  fillchar(f,sizeof(f),$ff);
  init;
  main;
  close(input); close(output);
end.
