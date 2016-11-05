{
ID:kjinxin1
PROG:numtri
LANG:PASCAL
}
var
  i,j:longint;
  g,f:array[0..1000,0..1000] of longint;
  r,ans:longint;
function max(m,n:longint):longint;
begin
  if m>n then exit(m)
  else exit(n);
end;
begin
  assign(input,'numtri.in');
  reset(input);
  assign(output,'numtri.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(f,sizeof(f),$ff);
  readln(r);
  for i:= 1 to r do
    begin
      for j:= 1 to i do
        read(g[i,j]);
      readln;
    end;
  f[1,1]:=g[1,1];
  for i:= 2 to r do
    for j:= 1 to i do
      begin
        if f[i-1,j]<>-1 then
          f[i,j]:=f[i-1,j]+g[i,j];
        if f[i-1,j-1]<>-1 then
          f[i,j]:=max(f[i,j],f[i-1,j-1]+g[i,j]);
      end;
  ans:=-maxlongint;
  for i:= 1 to r do
    begin
      if f[r,i]>ans then ans:=f[r,i];
    end;
  writeln(ans);
  close(input);
  close(output);
end.