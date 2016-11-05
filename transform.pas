{
ID:kjinxin1
PROG:transform
LANG:PASCAL
}
var
  n,i,j:longint;
  g,a,b,c:array[1..10,1..10] of char;

function try1:boolean;
var
  i,j:longint;
  o:boolean;
begin
  o:=true;
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        a[j,n-i+1]:=g[i,j];
      end;
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        if a[i,j]<>b[i,j] then
          o:=false;
        if not o then break;
      end;
  try1:=o;
end;
function try2:boolean;
var
  i,j:longint;
  o:boolean;
begin
  o:=true;
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        a[n-i+1,n-j+1]:=g[i,j];
      end;
  for i:= 1 to n do
    begin
      for j:= 1 to n do
        begin
          if a[i,j]<>b[i,j] then
            o:=false;
          if not o then break;
        end;
    end;
  try2:=o;
end;
function try3:boolean;
var
  i,j:longint;
  o:boolean;
begin
  o:=true;
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        a[n-i+1,i]:=g[i,j];
      end;
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        if a[i,j]<>b[i,j] then
          o:=false;
        if not o then break;
      end;
  try3:=o;
end;
function try4:boolean;
var
  i,j:longint;
  o:boolean;
begin
  o:=true;
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        a[i,n-j+1]:=g[i,j];
      end;
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        if a[i,j]<>b[i,j] then
          o:=false;
        if not o then break;
      end;
  try4:=o;
end;
function try5:boolean;
var
  i,j:longint;
  o:boolean;
begin
  o:=false;
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        a[i,n-j+1]:=g[i,j];
      end;
  c:=g;
  g:=a;
  if try1 or try2 or try3 then
    begin
      writeln('5');
      o:=true;
    end;
  g:=c;
  try5:=o;
end;
function try6:boolean;
var
  i,j:longint;
  o:boolean;
begin
  for i:= 1 to n do
    for j:= 1 to n do
      begin
        if g[i,j]<>b[i,j] then
          o:=false;
        if not o then break;
      end;
  if o then writeln('6');
  try6:=o;
end;
begin
  assign(input,'transform.in');
  reset(input);
  assign(output,'transform.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(a,sizeof(a),0);
  readln(n);
  for i:= 1 to n do
    begin
      for j:= 1 to n do
        begin
          read(g[i,j]);
        end;
      readln;
    end;
  for i:= 1 to n do
    begin
      for j:= 1 to n do
        begin
          read(b[i,j]);
        end;
      readln;
    end;
  if try1 then writeln('1') else
  if try2 then writeln('2') else
  if try3 then writeln('3') else
  if try4 then writeln('4') else
  if not try5 then
  if not try6 then
    writeln('7');
  close(input);
  close(output);
end.
