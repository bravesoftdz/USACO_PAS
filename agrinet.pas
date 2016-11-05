{
ID:kjinxin1
PROG:agrinet
LANG:PASCAL
}
var
  n,i,j,l,t,ans:longint;
  g:array[0..100,0..100] of longint;
  a:array[0..100] of longint;
  hash:array[0..100] of boolean;
begin
  assign(input,'agrinet.in');
  reset(input);
  assign(output,'agrinet.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(hash,sizeof(hash),0);
  readln(n);
  for i:= 1 to n do
    a[i]:=maxlongint;
  for i:= 1 to n do
    begin
      for j:= 1 to n do
        begin
          read(g[i,j]);
        end;
      readln;
    end;
  for i:= 1 to n do
    a[i]:=g[1,i];
  hash[1]:=true;
  for l:= 1 to n-2 do
    begin
      t:=maxlongint;
      for i:= 1 to n do
        begin
          if not hash[i] and (a[i]<t) then
            begin
              j:=i;
              t:=a[i];
            end;
        end;
      for i:= 1 to n do
        begin
          if (g[j,i]<a[i]) and (i<>j) and not hash[i]then
            begin
              a[i]:=g[j,i];
            end;
        end;
      hash[j]:=true;
    end;
  ans:=0;
  for i:= 1 to n do
    inc(ans,a[i]);
  writeln(ans);
  close(input); close(output);
end.