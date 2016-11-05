{
ID:kjinxin1
PROG:milk
LANG:PASCAL
}
type
  node=record
    a,p:longint;
  end;
var
  n,i,j,m,sum,ans:longint;
  g:array[0..5000] of node;
  o:boolean;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:node;
begin
  l1:=m; l2:=n; x:=g[(l1+l2) shr 1].p;
  repeat
    while g[l1].p<x do inc(l1);
    while g[l2].p>x do dec(l2);
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
  if m<l2 then paixu(m,l2);
end;
begin
  assign(input,'milk.in');
  reset(input);
  assign(output,'milk.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  readln(n,m);
  for i:= 1 to m do
    begin
      readln(g[i].p,g[i].a);
    end;
  paixu(1,m);
  sum:=0; o:=true; ans:=0;
  for i:= 1 to m do
    begin
      if sum+g[i].a>=n then
        begin
          ans:=ans+g[i].p*(n-sum);
          break;
        end;
      sum:=sum+g[i].a;
      ans:=ans+g[i].p*g[i].a;
    end;
  writeln(ans);
  close(input);
  close(output);
end.