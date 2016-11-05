{
ID:kjinxin1
PROG:ratios
LANG:PASCAL
}
var
  ans,ct:array[1..3] of integer;
  g:array[1..3,1..3] of integer;
  a1,b1,c1,i,j,dep:longint;
  o:boolean;
function min(m,n:longint):longint;
begin
  if m<n then min:=m else min:=n;
end;
procedure try1(var l1:longint; t1,t2,t3,a,b,c:longint);
var
  i,j:longint;
begin
  if t1<>0 then l1:=a div t1;
  if (t2<>0) then
    if t1<>0 then l1:=min(l1,b div t2)
    else l1:= b div t2;
  if (t3<>0) then
    if (t2<>0) or (t1<>0) then l1:=min(l1,c div t3)
    else l1:= c div t3;
end;
procedure search(a,b,c:longint);
var
  i,j,k,l1,l2,l3,t1,t2,t3:longint;
begin
  try1(l1,g[1,1],g[1,2],g[1,3],a,b,c);
  try1(l2,g[2,1],g[2,2],g[2,3],a,b,c);
  try1(l3,g[3,1],g[3,2],g[3,3],a,b,c);
  for i:= 0 to l1 do
    for j:= 0 to l2 do
      for k:= 0 to l3 do
        begin
          t1:=g[1,1]*i+g[2,1]*j+g[3,1]*k;
          t2:=g[1,2]*i+g[2,2]*j+g[3,2]*k;
          t3:=g[1,3]*i+g[2,3]*j+g[3,3]*k;
          if (t1>a) or (t2>b) or (t3>c) then break;
          if (t1=a) and (t2=b) and (t3=c) then
            begin
              o:=true;
              writeln(i,' ',j,' ',k,' ',dep);
              exit;
            end;
        end;
end;
begin
  assign(input,'ratios.in');
  reset(input);
  assign(output,'ratios.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  readln(a1,b1,c1);
  for i:= 1 to 3 do
    readln(g[i,1],g[i,2],g[i,3]);
  o:=false;
  for dep:= 1 to 100 do
    begin
      fillchar(ct,sizeof(ct),0);
      search(a1*dep,b1*dep,c1*dep);
      if o then break;
    end;
  if not o then
    writeln('NONE');
  close(input);
  close(output);
end.