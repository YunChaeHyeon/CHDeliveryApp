//
//  EditUserView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/08.
//

import SwiftUI

struct EditUserView : View {
    // 작성 혹은 편집한 메모의 저장 버튼을 누를 시 자동으로 창을 닫기 위해 선언
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var homeState : HomeState
    @ObservedObject var userVM : UserViewModel

    @State var name : String = ""
    @State var image: Image?
    
    @State var selectedUIImage: UIImage?
    @State var showImagePicker = false

    @State var imageChangeWhether = false
    
    @State private var showingAlert = false
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        
        let user = userVM.users.first
        
        VStack{
            //프로필
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                if let image = image{
                    //이미지 골랐으면
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                }
                else{
                    //DB에 이미지 있으면 NSData래핑
                    userVM.imageInit()
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
//                    let userImage2 = UIImage(data: userVM.getImage() as! Data)
//                    let image2 = Image(uiImage: userImage2!)
//                    image2
//                            .resizable()
//                            .frame(width: 80, height: 80)
//                            .clipShape(RoundedRectangle(cornerRadius: 100))
                }

            }).sheet(isPresented: $showImagePicker, onDismiss: {
                loadImage()
                imageChangeWhether = true
            }) {
                ImagePicker(image: $selectedUIImage)
            }
            
            //닉네임
            HStack{
                Spacer()
                Text("닉네임").foregroundColor(Color.black).padding(.trailing,20)
                
                TextField("\(userVM.getname())", text: $name)
                    .frame(width: 120,height: 40)
                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .background(Color(uiColor: .secondarySystemBackground))
                Spacer()
            }

            Spacer()
            
            Button(action: {
                if(name == ""){
                    print("name = null ")
                    self.showingAlert = true
                    //userVM.add(name: name)
                }else{
                    if(user == nil){
                        print("user == nil")
                        userVM.addUser(name: name)
                    }else{
                        self.showingAlert = false
                        print("user != nil")
                        if imageChangeWhether == false {
                            print("imageChangeWhether = false")
                            selectedUIImage = userVM.getUIImage()
                        }
                        let imageData = selectedUIImage!.jpegData(compressionQuality: 0.5)! as NSData

                        userVM.editUser(old: user! , name: name , userImage: imageData)
                    
                    }

                    dismiss()
                }
                
            }, label: {
                Text("변경 완료").foregroundColor(Color.white).font(.system(size: 20, weight: .bold))
                    .frame(width: 200, height: 40)
                    .background(Color.gray)
                    .cornerRadius(15)
                    .padding()
            })
            .frame(maxHeight: .infinity, alignment: .bottom)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(""), message: Text("닉네임을 입력해주세요"), dismissButton: .default(Text("네")))
            }
            
            
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
        EditUserView(homeState: HomeState(),userVM: UserViewModel())
    }
}
