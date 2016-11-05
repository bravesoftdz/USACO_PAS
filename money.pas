{
ID:kjinxin1
PROG:money
LANG:PASCAL
}
var
  n,v,i,j:longint;
  data:array[0..25] of int64;
  f:array[0..25,0..10000] of int64;
begin
  assign(input,'money.in');
  reset(input);
  assign(output,'money.out');
  rewrite(output);
  fillchar(data,sizeof(data),0);
  fillchar(f,sizeof(f),0);
  readln(v,n);
  for i:= 1 to v do
    begin
      read(data[i]);
    end;
  for i:= 0 to v do
    f[i,0]:=1;
  for i:= 1 to v do
    for j:= 1 to n do
      begin
        if j>=data[i] then f[i,j]:=f[i-1,j]+f[i,j-data[i]]
        else f[i,j]:=f[i-1,j];
      end;
  writeln(f[v,n]);
  close(input); close(output);
end.