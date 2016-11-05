var
  n,i,j:longint;
  ans,sum,num:longint;
  f:array[0..39,0..780] of longint;
function search(top,sum:longint):longint;
var
  i,j:longint;
begin
  if sum<0 then exit;
  if sum=0 then
    begin
      exit(1);
    end;
  if top<1 then exit(0);
  if (1+top)*top shr 1<sum then exit(0);
  j:=0;
  for i:= top downto 1 do
    begin
      if (sum-i>=0) and (f[i-1,sum-i]=-1) then
        f[i-1,sum-i]:=search(i-1,sum-i);
      if sum-i>=0 then inc(j,f[i-1,sum-i])
    end;
  search:=j;
end;
begin
  assign(input,'input.txt');
  reset(input);
  assign(output,'output.txt');
  rewrite(output);
  fillchar(f,sizeof(f),$ff);
  readln(n);
  ans:=0; sum:=n;
  num:=(1+n)*n shr 1;
  if num and 1=1 then writeln('0')
  else
    begin
       num:=num shr 1;
       f[n-1,num-n]:=search(n-1,num-n);
       writeln(f[n-1,num-n]);
    end;
  close(input); close(output);
end.