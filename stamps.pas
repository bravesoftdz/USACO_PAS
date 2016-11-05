{
ID:kjinxin1
PROG:stamps
LANG:PASCAL
}
var
  value:array[0..100] of longint;
  f:array[0..2000000] of longint;
  ans,max,n,k,i,j,l:longint;
  o:boolean;

procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:longint;
begin
  l1:=m; l2:=n; x:=value[(l1+l2) shr 1];
  repeat
    while value[l1]<x do inc(l1);
    while value[l2]>x do dec(l2);
    if l1<=l2 then
      begin
        t:=value[l1];
        value[l1]:=value[l2];
        value[l2]:=t;
        inc(l1);  dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if l2>m then paixu(m,l2);
end;
begin
  assign(input,'stamps.in');
  reset(input);
  assign(output,'stamps.out');
  rewrite(output);
  readln(k,n); j:=0;
  while not eof do
    begin
      while not eoln do
        begin
          inc(j);
          read(value[j])
        end;
      readln;
    end;
  fillchar(f,sizeof(f),$ff);
  f[0]:=0;
  paixu(1,n);
  max:=value[n]*k; o:=true;
  if value[1]=1 then
    begin
      for i:= 1 to max+1 do
        begin
        if not o then break;
        for j:= n downto 1 do
          begin
            if value[j]>i then continue;
            for l:= 1 to i div value[j] do
              begin
                if f[i]<>-1 then
                  begin
                    if (f[i-value[j]*l]<>-1) and (f[i]<=f[i-value[j]*l]+l) then
                      break;
                    if (f[i-value[j]*l]<>-1) and (f[i]>f[i-value[j]*l]+l) then
                      begin
                          f[i]:=f[i-value[j]*l]+l
                      end;
                  end
                else
                  begin
                    if (f[i-value[j]*l]<>-1) and (f[i-value[j]*l]+l<=k) then
                      begin
                        f[i]:=f[i-value[j]*l]+l;
                      end;
                  end;
              end;
          end;
         if f[i]=-1 then
           begin
             writeln(i-1);
             o:=false;
           end;
       end;
    end
  else
    begin
      ans:=0;
    end;
  close(input); close(output);
end.
////////////////////////////////////
var s:array[1..50] of integer;
    k,n:integer;
 
procedure init;
  var i:integer;
  begin
    readln(k,n);
    for i:=1 to n do
      read(s[i]);
  end;
 
procedure work;
  var f:array[0..2000000] of boolean;
      u:array[0..2000000] of byte;
      i:integer;
      ans:longint;
  begin
    fillchar(f,sizeof(f),false);
    fillchar(u,sizeof(u),0);
    f[0]:=true;
    ans:=0;
    while f[ans] do
      begin
        if u[ans]<k then
          for i:=1 to n do
            if not(f[ans+s[i]]) then
              begin
                f[ans+s[i]]:=true;
                u[ans+s[i]]:=u[ans]+1;
              end
            else
              if u[ans]+1<u[ans+s[i]] then
                begin
                  f[ans+s[i]]:=true;
                  u[ans+s[i]]:=u[ans]+1;
                end;
        ans:=ans+1;
      end;
      writeln(ans-1);
  end;
 
begin
  assign(input,'stamps.in');
  assign(output,'stamps.out');
  reset(input);
  rewrite(output);
  init;
  work;
  close(input);
  close(output);
end.
/////////////////////////////
const
maxn=200000;
var
k,n,ans:longint;
a:array[1..100] of longint;
sum,now,num:array[0..maxn] of longint;
f:array[1..2000000] of 0..1;
procedure openf;
begin
        assign(input,'stamps.in'); reset(input);
        assign(output,'stamps.out'); rewrite(output);
end;
procedure closef;
begin
        close(input); close(output);
        halt;
end;
procedure init;
var
i:longint;
begin
        openf;
        readln(k,n);
        for i:=1 to n do read(a[i]);
end;
procedure main;
var
t,w,i:longint;
begin
        t:=0; w:=n;
        for i:=1 to n do
        begin
                sum[i]:=a[i]; now[i]:=i;
                num[i]:=1; f[a[i]]:=1;
        end;
        while t<>w do
        begin
                t:=(t+1) mod maxn;
                if num[t]<k then
                for i:=now[t] to n do
                if f[sum[t]+a[i]]=0 then
                begin
                        w:=(w+1) mod maxn; sum[w]:=sum[t]+a[i];
			now[w]:=i; num[w]:=num[t]+1;
                        f[sum[t]+a[i]]:=1;
                end;
        end;
        ans:=1;
        while f[ans]=1 do inc(ans);
        writeln(ans-1);
        closef;
end;
begin
        init;
        main;
end.
///////////////////////////
var i,j,t,k,n,min,maxn:longint;
f:array[0..2000000] of longint;
num:array[1..200] of longint;
 
begin
assign(input,'stamps.in');
assign(output,'stamps.out');
reset(input);
rewrite(output);
readln(k,n);
 
for i:=1 to n do 
   begin 
     read(num[i]);
        if num[i]>maxn 
          then 
           maxn:=num[i];
   end;
 
f[0]:=0;
 
for i:=1 to k*maxn+1 do
    begin
    min:=maxlongint;
        for t:=1 to n do
            if (i-num[t]>=0)and(f[i-num[t]]+1<=k)
               then begin
                    if f[i-num[t]]+1<min
                       then
                          min:=f[i-num[t]]+1;
                    end;
    if min=maxlongint
         then
           begin
             writeln(i-1);
             close(output);
	     halt;
           end
    else f[i]:=min;
    end;
 
end.