{
ID:kjinxin1
PROG:kimbits
LANG:PASCAL
}
var
  j,x,n,l,p:longint;
  a:array[0..100] of integer;
  f:array[0..40,0..40] of int64;
  i,t,ans,k:int64;

function search(i,j:longint):int64;
var
  p,q:longint;
begin
  if j=0 then exit(1);
  if j=1 then exit(i+1);
  if f[i,j]<>-1 then exit(f[i,j]);
  if i=j then exit(1 shl i);
  if f[i-1,j]=-1 then f[i-1,j]:=search(i-1,j);
  if f[i-1,j-1]=-1 then f[i-1,j-1]:=search(i-1,j-1);
  f[i,j]:=f[i-1,j-1]+f[i-1,j];
  search:=f[i,j];
end;
begin
  assign(input,'kimbits.in');
  reset(input);
  assign(output,'kimbits.out');
  rewrite(output);
  readln(n,l,i);
  fillchar(f,sizeof(f),$ff);
  fillchar(a,sizeof(a),0);
  f[n,l]:=search(n,l);
  j:=n;
  while (f[j,l]>=i) and (j>=l) do dec(j);
  if j>=l then
    begin
      ans:=f[j,l];
      p:=j;
      while (ans+f[p,l-1]>=i) and (p>=l-1) do
      dec(p);
      if p>=l-1 then
        begin
         ans:=ans+f[p,l-1];
         t:=1 shl j+1 shl p;
        end
      else t:=1 shl j;
    end
  else
    begin
      if f[n,l]=i then
        begin
          ans:=f[n,l];
          t:=1 shl n;
        end
      else
        begin
        t:=0; ans:=0;
        end;
    end;
  k:=t-1;
  while ans<i do
    begin
      x:=t;
      x:=(x and $55555555)+((x shr 1) and $55555555);
      x:=(x and $33333333)+((x shr 2) and $33333333);
      x:=(x and $0F0F0F0F)+((x shr 4) and $0F0F0F0F);
      x:=(x and $00FF00FF)+((x shr 8) and $00FF00FF);
      x:=(x and $0000FFFF)+((x shr 16) and $0000FFFF);
      if x<=l then
        begin
          inc(ans);
          k:=t;
        end;
      inc(t);
    end;
  x:=0;
  while k>0 do
    begin
      inc(x);
      a[x]:=k mod 2;
      k:=k div 2;
    end;
  for p:= n downto x+1 do write('0');
  for p:= x downto 1 do
    write(a[p]);
  writeln;
  close(input); close(output);
end.
