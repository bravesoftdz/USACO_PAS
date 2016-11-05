{
ID:kjinxin1
PROG:rockers
LANG:PASCAL
}
var
  a:array[0..30] of longint;
  f:array[0..20,0..20,0..20] of longint;
  n,t,m,i,j:longint;
procedure init;
var
  i,j:longint;
begin
  fillchar(a,sizeof(a),0);
  fillchar(f,sizeof(f),$ff);
  readln(n,t,m);
  for i:= 1 to n do
    read(a[i]);
end;
function min(m,n:longint):longint;
begin
  if m<n then exit(m) else exit(n);
end;
function max(m,n:longint):longint;
begin
  if m>n then exit(m) else exit(n);
end;
procedure main;
var
  ans,i,j,k:longint;
begin
  for i:= 0 to t do
    for j:= 0 to m do
      f[0,j,i]:=0;
  f[0,0,i]:=0;
  for i:= 1 to n do
    for j:= 1 to m do
      begin
        for k:= t downto 0  do
          begin
            f[i,j,k]:=f[i-1,j,k];
            if k+a[i]<=t then
              begin
                f[i,j,k]:=max(f[i-1,j,k+a[i]]+1,f[i,j,k]);
              end;
            f[i,j,k]:=max(f[i,j,k],f[i,j,k+1]);
            f[i,j,k]:=max(f[i,j,k],f[i,j-1,0]);
          end;
        if a[i]<=t then f[i,j,t-a[i]]:=max(f[i,j,t-a[i]],f[i-1,j-1,0]+1);
      end;
  ans:=0;
  for i:= 0 to t do
    begin
      if f[n,m,i]>ans then ans:=f[n,m,i];
    end;
  writeln(ans);
end;
begin
  assign(input,'rockers.in'); reset(input);
  assign(output,'rockers.out'); rewrite(output);
  init;
  main;
  close(input); close(output);
end.