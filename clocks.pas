{
ID:kjinxin1
PROG:clocks
LANG:PASCAL
}
const
    change:array[1..9,1..9]of integer=
                 ((3,3,3,3,3,2,3,2,0),
                 (2,3,2,3,2,3,1,0,1),
                 (3,3,3,2,3,3,0,2,3),
                 (2,3,1,3,2,0,2,3,1),
                 (2,3,2,3,1,3,2,3,2),
                 (1,3,2,0,2,3,1,3,2),
                 (3,2,0,3,3,2,3,3,3),
                 (1,0,1,3,2,3,2,3,2),
                 (0,2,3,2,3,3,3,3,3));
var
  ans,g:array[1..9] of longint;
  f:array[0..100] of longint;
procedure init;
var
  i,j:longint;
begin
  fillchar(ans,sizeof(ans),0);
  fillchar(g,sizeof(g),0);
  for i:= 1 to 9 do
    begin
      read(g[i]);
      if i mod 3=0 then readln;
      g[i]:=g[i] div 3;
    end;
end;
procedure main;
var
  i,j,t:longint;
begin
  for i:= 1 to 9 do
    for j:= 1 to 9 do
      begin
        inc(ans[j],change[i,j]*(4-g[i]));
      end;
  for i:= 1 to 9 do
    ans[i]:=ans[i] and 3;
  t:=0;
  fillchar(f,sizeof(f),0);
  for i:= 1 to 9 do
    begin
      for j:= 1 to ans[i] do
        begin
          inc(t);f[t]:=i;
        end;
    end;
  for i:= 1 to t-1 do
    write(f[i],' ');
  writeln(f[t]);
end;
begin
  assign(input,'clocks.in');
  reset(input);
  assign(output,'clocks.out');
  rewrite(output);
  init;
  main;
  close(input);
  close(output);
end.
