{
ID:kjinxin1
PROG:barn1
LANG:PASCAL
}
var
  t,m,s,k,c,i,j:longint;
  g:array[0..200] of longint;
  f:array[0..200,0..50] of longint;
function min(m,n:longint):longint;
begin
  if m<n then exit(m)
  else exit(n);
end;
procedure paixu(m,n:longint);
var
  l1,l2,x,t:longint;
begin
  l1:=m; l2:=n; x:=g[(l1+l2) shr 1];
  repeat
    while g[l1]<x do inc(l1);
    while g[l2]>x do dec(l2);
    if l1<=l2 then
      begin
        t:=g[l1];
        g[l1]:=g[l2];
        g[l2]:=t;
        inc(l1);
        dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if l2>m then paixu(m,l2);
end;
begin
  assign(input,'barn1.in');
  reset(input);
  assign(output,'barn1.out');
  rewrite(output);
  fillchar(f,sizeof(f),$ff);
  fillchar(g,sizeof(g),0);
  readln(m,s,c);
  for i:= 1 to c do
    begin
      readln(g[i]);
    end;
  paixu(1,c);
  for i:= 1 to c do
    begin
      f[i,1]:=g[i]-g[1]+1;
    end;
  for i:= 2 to c do
    for j:= 2 to min(m,i) do
      begin
        for k:= 1 to i-1 do
          begin
            if f[k,j-1]<>-1 then
              begin
                if f[i,j]=-1 then f[i,j]:=f[k,j-1]+g[i]-g[k+1]+1
                else
                  f[i,j]:=min(f[i,j],f[k,j-1]+g[i]-g[k+1]+1);
              end;
          end;
      end;
  writeln(f[c,min(m,c)]);
  close(input);
  close(output);
end.