{
ID:kjinxin1
PROG:fact4
LANG:PASCAL
}
var
  i,j,k5,k10,n:longint;
  ans:int64;
procedure try1(var t:longint);
var
  i,j:longint;
begin
  t:=(t*2) div 10;
  if (t mod 5=0) then
    begin
      inc(k5);
      try1(t);
    end;
end;
procedure try2(var t:longint);
var
  i,j:longint;
begin
  while t mod 10=0 do
    t:=t div 10;
  if t mod 5=0 then
    begin
      inc(k5);
      try1(t);
    end;
end;
begin
  assign(input,'fact4.in');
  reset(input);
  assign(output,'fact4.out');
  rewrite(output);
  readln(n);
  k5:=n div 5;
  k5:=k5-n div 10;
  ans:=1;
  for i:= 2 to n do
    begin
      j:=i;
      if j mod 10=0 then try2(j)
      else if j mod 5=0 then try1(j);
      ans:=ans*(j mod 10);
      while (ans and 1=0) and (k5>0) do
        begin
          ans:=ans shr 1;
          dec(k5);
        end;
      ans:=ans mod 10;
    end;
  writeln(ans);
  close(input); close(output);
end.
