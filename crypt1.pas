{
ID:kjinxin1
PROG:crypt1
LANG:PASCAL
}
var
  i,j,k,l,p,n,w,ans:longint;
  a,b:array[0..10] of integer;
  t:set of 0..100;
begin
  assign(input,'crypt1.in');
  reset(input);
  assign(output,'crypt1.out');
  rewrite(output);
  fillchar(a,sizeof(a),0);
  fillchar(b,sizeof(b),0);
  readln(n);
  t:=[];
  for i:= 1 to n do
    begin
      read(a[i]);
      t:=t+[a[i]];
    end;
  ans:=0;
  for i:= 1 to n do
    for j:= 1 to n do
      for k:= 1 to n do
        for l:= 1 to n do
          for p:= 1 to n do
            begin
              b[1]:=a[i]*a[l];
              b[2]:=b[1] div 10+a[j]*a[l];
              b[1]:=b[1] mod 10;
              if not (b[1] in t) then continue;
              b[3]:=b[2] div 10+a[k]*a[l];
              b[2]:=b[2] mod 10;
              if not (b[2] in t) then continue;
              if not (b[3] in t) then continue;
              b[4]:=a[i]*a[p];
              b[5]:=b[4] div 10+a[j]*a[p];
              b[4]:=b[4] mod 10;
              if not (b[4] in t) then continue;
              b[6]:=b[5] div 10+a[k]*a[p];
              b[5]:=b[5] mod 10;
              if not (b[5] in t) then continue;
              if not (b[6] in t) then continue;
              b[7]:=b[1];
              b[8]:=b[2]+b[4];
              b[9]:=b[3]+b[5]+b[8] div 10;
              b[8]:=b[8] mod 10;
              b[10]:=b[6]+b[9] div 10;
              b[9]:=b[9] mod 10;
              if not (b[7] in t) then continue;
              if not (b[8] in t) then continue;
              if not (b[9] in t) then continue;
              if not (b[10] in t) then continue;
              inc(ans);
            end;
  writeln(ans);
  close(input);
  close(output);
end.
