{
ID:kjinxin1
PROG:inflate
LANG:PASCAL
}
type
  node=record
    value,time:longint;
  end;
var
  n,m,i,j,va,ti,top:longint;
  a,g:array[0..10000] of node;
  f:array[0..10000] of longint;
function max(m,n:longint):longint;
begin
  if m>n then exit(m) else exit(n);
end;
begin
  assign(input,'inflate.in');
  reset(input);
  assign(output,'inflate.out');
  rewrite(output);
  fillchar(a,sizeof(a),0);
  fillchar(g,sizeof(g),0);
  fillchar(f,sizeof(f),0);
  readln(m,n); va:=0; ti:=maxlongint;
  for i:= 1 to n do
    begin
      readln(a[i].value,a[i].time);
      if (a[i].value>=va) and (a[i].time<=ti) then
        begin
          va:=a[i].value; ti:=a[i].time;
        end;
    end;
  top:=0;
  for i:= 1 to n do
    begin
      if (a[i].value<va) and (a[i].time>ti) or (a[i].time>m) then
        continue;
      inc(top);
      g[top]:=a[i];
    end;
  for i:= 1 to top do
    for j:= 0 to m do
      begin
        if j>=g[i].time then
          begin
            f[j]:=max(f[j],f[j-g[i].time]+g[i].value);
          end;
      end;
  writeln(f[m]);
  close(input); close(output);
end.