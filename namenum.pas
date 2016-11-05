{
ID:kjinxin1
PROG:namenum
LANG:PASCAL
}
const
  hash:array[1..24] of char=('A','B','C',
                             'D','E','F',
                             'G','H','I',
                             'J','K','L',
                             'M','N','O',
                             'P','R','S',
                             'T','U','V',
                             'W','X','Y');
type
  node=record
    fi,ju:0..1;
    next:longint;
  end;
var
  tri:array[0..29000,'A'..'Z'] of node;
  top,t,i,j,l:longint;
  ans:array[0..14] of char;
  ch:char;
  st:string;
  o:boolean;

procedure build(st:string);
var
  i,j,t:longint;
begin
  t:=1; j:=length(st);
  for i:= 1 to j do
    begin
      if tri[t,st[i]].ju=1 then
        begin
          if tri[t,st[i]].next=0 then
            begin
              if i<>j then
                begin
                  inc(top);
                  tri[t,st[i]].next:=top;
                  t:=top;
                end;
            end
          else
            t:=tri[t,st[i]].next;
        end
      else
        begin
          tri[t,st[i]].ju:=1;
          if i<>j then
            begin
              inc(top);
              tri[t,st[i]].next:=top;
              t:=top;
            end;
        end;
    end;
  tri[t,st[j]].fi:=1;
end;

procedure search(t,top,sum:longint);
var
  i,j:longint;
  ch:longint;
begin
  if top=0 then exit;
  if t>l then exit;
  ch:=3*(ord(st[t])-ord('0')-2);
  for i:= 1 to 3 do
    begin
      inc(sum);
      ans[sum]:=hash[ch+i];
      if tri[top,hash[ch+i]].ju=1 then
        begin
          if t=l then
            begin
              if tri[top,hash[ch+i]].fi=1 then
                begin
                  for j:= 1 to sum do
                    begin
                      write(ans[j]);
                    end;
                  writeln;
                  o:=true;
                end;
            end
          else
            begin
              search(t+1,tri[top,hash[ch+i]].next,sum);
            end;
        end;
      dec(sum);
    end;
end;
begin
  assign(input,'dict.txt');
  reset(input);
  fillchar(tri,sizeof(tri),0);
  top:=1;
  for i:= 1 to 4617 do
    begin
      readln(st);
      build(st);
    end;
  close(input);
  assign(input,'namenum.in');
  reset(input);
  fillchar(ans,sizeof(ans),0);
  assign(output,'namenum.out');
  rewrite(output);
  readln(st);
  l:=length(st);
  o:=false;
  search(1,1,0);
  if not o then writeln('NONE');
  close(input);
  close(output);
end.