//
//  EditUserView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/08.
//

import SwiftUI

struct EditUserView : View {

    @ObservedObject var homeState : HomeState
    @ObservedObject var userVM : UserViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var name : String = ""
    //var user = userVM.users.first
    //var userData : User
    
    var body: some View {
        var user = userVM.users.first
        
        VStack{
            //프로필
            Image("userDefault")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .padding(20)
            //닉네임
            HStack{
                Spacer()
                Text("닉네임").foregroundColor(Color.black).padding(.trailing,20)
                
                TextField("닉네임", text: $name)
                    .frame(width: 120,height: 40)
                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .background(Color(uiColor: .secondarySystemBackground))
                Spacer()
            }

            Spacer()
            
            Button(action: {
                //userVM.editMemo(old: user[0], name: "YCH")
                if(user == nil){
                    print("user == nil")
                    userVM.add(name: name)
                }else{
                    print("user != nil")
                    userVM.editMemo(old: user! , name: name)
                }
                
                //userVM.delete(old: user[0])
            }, label: {
                Text("변경 완료").foregroundColor(Color.white).font(.system(size: 20, weight: .bold))
                    .frame(width: 200, height: 40)
                    .background(Color.gray)
                    .cornerRadius(15)
                    .padding()
            })
            .frame(maxHeight: .infinity, alignment: .bottom)
            
            
            
        }//VStack
        .onAppear(perform: {
                homeState.isHiddenTap()
        })
        .navigationBarBackButtonHidden(true)
        .toolbar {

                        // 2
                        ToolbarItem(placement: .navigationBarLeading) {
                            HStack{
                                Button {
                                    homeState.isVisibilityTap()
                                    dismiss()

                                } label: {
                                    // 4
                                    HStack {
                                        Image(systemName: "chevron.backward").foregroundColor(Color.black)
                                        Text("내 정보 수정").foregroundColor(Color.black)
                                       
                                    }
                                 }
                            }
                       }//ToolbarItem.
            
            }
        
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(homeState: HomeState(), userVM: UserViewModel())
    }
}
