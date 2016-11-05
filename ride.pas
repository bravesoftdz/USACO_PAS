{ID:kjinxin1
PROG:ride
LANG:PASCAL
}
const
  hash:array['A'..'Z'] of integer=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
                                    ,18,19,20,21,22,23,24,25,26);
var
  t1,t2,i,j:longint;
  st1,st2:char;
  k:char;
begin
  assign(input,'ride.in');
  reset(input);
  assign(output,'ride.out');
  rewrite(output);
  t1:=1; t2:=1;
  while not eoln do
    begin
      read(st1);
      t1:=t1*hash[st1];
    end;
  readln;
  while not eoln do
    begin
      read(st2);
      t2:=t2*hash[st2];
    end;
  if (t1 mod 47)=(t2 mod 47) then
    writeln('GO')
  else
    writeln('STAY');
  close(input);
  close(output);
end.
