{
ID:kjinxin1
PROG:zerosum
LANG:PASCAL
}
const
  data:array[1..3] of char=(' ','+','-');
var
  a,c:array[1..9] of longint;
  ch:array[1..8] of char;
  n,i,j:longint;
procedure try1;
var
  i,j,ans:longint;
begin
  ans:=0;
  for i:= 1 to n do
    a[i]:=i;
  for i:= 1 to n-1 do
    begin
      if ch[i]=' ' then
        begin
          a[i+1]:=a[i]*10+a[i+1];
          a[i]:=0;
        end;
    end;
  j:=1;
  while a[j]=0 do inc(j);
  ans:=a[j];
  for i:= 1 to n-1 do
    begin
      if ch[i]<>' ' then
        begin
          j:=i+1;
          while a[j]=0 do inc(j);
          case ch[i] of
            '+':begin
                  ans:=ans+a[j];
                end;
            '-':begin
                  ans:=ans-a[j];
                end;
          end;
        end;
    end;
  if ans=0 then
    begin
      write('1');
      for i:= 1 to n-1 do
        begin
          write(ch[i],i+1);
        end;
      writeln;
    end;
end;
procedure search(t:longint);
var
  i,j:longint;
begin
  if t=0 then
    begin
      try1;
      exit;
    end;
  for j:= 1 to 3 do
    begin
      ch[n-t]:=data[j];
      search(t-1);
    end;
end;
begin
  assign(input,'zerosum.in');
  reset(input);
  assign(output,'zerosum.out');
  rewrite(output);
  readln(n);
  search(n-1);
  close(input); close(output);
end.