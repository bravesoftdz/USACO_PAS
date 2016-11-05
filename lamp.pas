type
  node=record
    st:string;
    pos:integer;
  end;
var
  g1,g2:array[0..100] of integer;
  hash:array[0..100] of integer;
  hash1:array[1..100,1..4] of integer;
  st:array[1..100] of node;
  ans:array[1..4] of longint;
  h:array[0..1,0..1,0..1,0..1] of boolean;
  top1,c,k1,k2,n,i,j,k:longint;
  st1:node;
procedure search(t1,t2,t3,t4,top,sum:longint);
var
  i,j,l1,l2,l3,l4:longint;
  ch:char;
  o:boolean;
begin
      if h[t1,t2,t3,t4]=false then
        begin
          o:=true;
          ans[1]:=t1; ans[2]:=t2; ans[3]:=t3; ans[4]:=t4;
          for i:= 1 to k1 do
            begin
              if ans[hash[g1[i]]]=0 then
                begin
                  o:=false; break;
                end;
            end;
          for i:= 1 to k2 do
            begin
              if ans[hash[g2[i]]]=1 then
                begin
                  o:=false; break;
                end;
            end;
          if o and ((c-sum) mod 2=0) then
            begin
          inc(top1);
          for i:= 1 to 4 do
            begin
              st[top1].st:=st[top1].st+chr(ans[i]);
              hash1[top1,i]:=ans[i];
            end;
          st[top1].pos:=top1;
          h[t1,t2,t3,t4]:=true;
            end;
        end;
  if top>4 then exit;
  if sum<=0 then exit;
  for i:= top to 4 do
    begin
      case i of
        1:begin
            if t1=0 then l1:=1
            else l1:=0;
            if t2=0 then l2:=1
            else l2:=0;
            if t3=0 then l3:=1
            else l3:=0;
            if t4=0 then l4:=1
            else l4:=0;
          end;
        2:begin
            if t1=0 then l1:=1
            else l1:=0;
            l2:=t2;
            if t3=0 then l3:=1
            else l3:=0;
            l4:=t4;
          end;
        3:begin
            l1:=t1;
            if t2=0 then l2:=1
            else l2:=0;
            l3:=t3;
            if t4=0 then l4:=1
            else l4:=0;
          end;
        4:begin
            if t1=0 then l1:=1
            else l1:=0;
            l2:=t2;
            l3:=t3;
            if t4=0 then l4:=1
            else l4:=0;
          end;
      end;
      search(l1,l2,l3,l4,i+1,sum-1);
    end;
end;
begin
  assign(input,'input.txt');
  reset(input);
  assign(output,'output.txt');
  rewrite(output);
  top1:=0;
  fillchar(g1,sizeof(g1),0);
  fillchar(g2,sizeof(g2),0);
  fillchar(hash,sizeof(hash),0);
  fillchar(hash1,sizeof(hash1),0);
  fillchar(h,sizeof(h),0);
  fillchar(ans,sizeof(ans),0);
  readln(n);
  readln(c);
  read(j); k1:=0; k2:=0;
  while j<>-1 do
    begin
      inc(k1);
      g1[k1]:=j;
      read(j);
    end;
  readln;
  read(j);
  while j<>-1 do
    begin
      inc(k2);
      g2[k2]:=j;
      read(j);
    end;
  for i:= 1 to n do
    begin
      if (i and 1=1) and ((i-1) mod 3=0) then
        begin
          hash[i]:=1;
        end
      else
      if (i and 1=0) and ((i-1) mod 3=0) then
        begin
          hash[i]:=4;
        end
      else
      if (i and 1=1) then
        begin
          hash[i]:=3;
        end
      else hash[i]:=2;
    end;
  if (c mod 4=0) and (c>=4) then c:=4
  else
  if ((c mod 4=3) or (c mod 4=1)) and (c>4) then c:=3
  else
  if (c mod 4=2) and (c>=4) then c:=4;
  search(1,1,1,1,1,c);
  if top1=0 then writeln('IMPOSSIBLE')
  else
    begin
      for i:= 1 to top1-1 do
        for j:= i+1 to top1 do
          begin
            if st[i].st>st[j].st then
              begin
                st1:=st[i];
                st[i]:=st[j];
                st[j]:=st1;
              end;
          end;
    end;
  for i:= 1 to top1 do
    begin
      k:=st[i].pos;
      for j:= 1 to n do
        begin
          write(hash1[k,hash[j]]);
        end;
      writeln;
    end;
  close(input);
  close(output);
end.