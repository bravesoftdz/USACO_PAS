type
  node=record
    fen,mu:longint;
  end;
var
  hash:array[0..160,0..160] of boolean;
  ans:array[0..160*160] of node;
  top,i,j,n,fen,mu:longint;

function judge(l1,l2:longint):boolean;
var
  j,a1,a2:longint;
begin
  a1:=ans[l1].mu; a2:=ans[l2].mu;
  while a1 mod a2<>0 do
    inc(a1,ans[l1].mu);
  if ans[l1].fen*(a1 div ans[l1].mu)<ans[l2].fen*(a1 div ans[l2].mu) then exit(true)
  else exit(false);
end;
procedure paixu(m,n:longint);
var
  x,l1,l2:longint;
  t:node;
begin
  l1:=m; l2:=n; x:=l1;
  repeat
    while judge(l1,x) do inc(l1);
    while judge(x,l2) do dec(l2);
    if l1<=l2 then
      begin
        t:=ans[l1];
        ans[l1]:=ans[l2];
        ans[l2]:=t;
        inc(l1);
        dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if m<l2 then paixu(m,l2);
end;
function gcd(fen,mu:longint):longint;
var
  t:longint;
begin
  if fen=mu then exit(fen);
  if fen>mu then
    begin
      t:=fen; fen:=mu; mu:=t;
    end;
  if (fen and 1=0) and (mu and 1=0) then gcd:=2*gcd(fen shr 1,mu shr 1)
  else
  if (fen and 1=0) and (mu and 1=1) then gcd:=gcd(fen shr 1,mu)
  else
  if (fen and 1=1) and (mu and 1=0) then gcd:=gcd(fen,mu shr 1)
  else
  gcd:=gcd((mu-fen) shr 1,fen);
end;
procedure try1(var fen,mu:longint);
var
  j:longint;
begin
  j:=gcd(fen,mu);
  fen:=fen div j; mu:=mu div j;
end;
begin
  assign(input,'input.txt');
  reset(input);
  assign(output,'output.txt');
  rewrite(output);
  fillchar(hash,sizeof(hash),0);
  fillchar(ans,sizeof(ans),0);
  readln(n);
  top:=2;
  hash[0,1]:=true; hash[1,1]:=true;
  ans[1].fen:=0; ans[1].mu:=1; ans[2].fen:=1; ans[2].mu:=1;
  for i:= 1 to n do
    for j:= 1 to i-1 do
      begin
        fen:=j; mu:=i;
        try1(fen,mu);
        if not hash[fen,mu] then
          begin
            hash[fen,mu]:=true;
            inc(top); ans[top].fen:=fen; ans[top].mu:=mu;
          end;
      end;
  paixu(1,top);
  for i:= 1 to top do
    begin
      writeln(ans[i].fen,'/',ans[i].mu);
    end;
  close(input); close(output);
end.