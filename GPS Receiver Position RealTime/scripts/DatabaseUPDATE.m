function [ Database ] = DatabaseUPDATE( Database, out )
    N = str2num(out.Name(end));
    if isempty(Database)
       Database.flag = 0; % ���� ������� ������ ������� - > ������������� ������ �� ��� ����������� �������
       Database.current_tow = out.TOW; % ������� ����� ���� (��� �������� ���������� ����� �������)
       Database.Smartphones = zeros(5,1); % ������ ������, ��� ���������� ������� ���� � �������
       Database.obs{1} = 0;
       Database.obs{2} = 0;
       Database.obs{3} = 0;
       Database.obs{4} = 0;
       Database.obs{5} = 0;
       Database.Smartphones(N,1) = 1;
       Database.obs{N} = out; 
       Database.current_obs = 0;
       
    else
       if Database.current_tow == out.TOW % ������ �����
           Database.Smartphones(N,1) = 1;
           Database.obs{N} = out;
           Database.flag = 0;
       else %������ ����� �����
           %������� ���
            Database.flag = 1;
            Database.current_obs = Database.obs;
            Database.current_list = Database.Smartphones;
%             if Database.Smartphones(1) && Database.Smartphones(2)
%             [ Base ] = GoRealTime( Database.obs{1}, Database.obs{2}, ephemeris );
% %             delta = Database.obs{1}.Position - Database.obs{2}.Position;
%             [ b(1,1), b(2,1), b(3,1) ] = geo2local_v2( Database.obs{2}.Position, Database.obs{1}.Position );
%             [Base b]
%             end
            

           %�����
            Database.Smartphones = zeros(5,1); % ������ ������, ��� ���������� ������� ���� � �������
            Database.obs{1} = 0;
            Database.obs{2} = 0;
            Database.obs{3} = 0;
            Database.obs{4} = 0;
            Database.obs{5} = 0;
            Database.Smartphones(N,1) = 1;
            Database.obs{N} = out; 
            Database.current_tow = out.TOW; 
       end
end

