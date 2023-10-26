//
//  MyStoreRegisterView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/11.
//

import Foundation
import SwiftUI



struct MyStoreRegisterView : View {
    // 작성 혹은 편집한 메모의 저장 버튼을 누를 시 자동으로 창을 닫기 위해 선언
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var homeState : HomeState
    @ObservedObject var storeRegiVM = StoreRegisterViewModel()
    
    @State var image : Image?
    @State var selectedUIImage : UIImage?
    @State var showImagePicker = false
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
        
        let imageData = selectedUIImage!.jpegData(compressionQuality: 0.5)! as NSData
        storeRegiVM.storeImage = imageData
    }
    
    var body: some View {

        ZStack(alignment: .bottom) {
            ScrollView {
                VStack{
                    //가게 대표 사진 추가
                    Button(action: {
                        showImagePicker.toggle()
                    }, label: {
                        if let image = image{
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .ignoresSafeArea(edges: .top)
                                .frame(height: 170)
                                .clipped()
                                .padding(.bottom , 20)
                        }
                        else{
                            VStack{
                                Text("대표 사진 등록").foregroundColor(Color.black)
                                Image(systemName: "plus.app.fill")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                            }.padding(.vertical, 20)
                        }


                    })
                        .sheet(isPresented: $showImagePicker, onDismiss: {
                            loadImage()
                            //imageChangeWhether = true
                        }) {
                            ImagePicker(image: $selectedUIImage)
                        }
                    
                    //Title
                    TextField("가게 이름 입력", text: $storeRegiVM.storeName)
                        .frame(width: 150)
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        //.background(Color(uiColor: .secondarySystemBackground))
                    // Text alignment.
                        .multilineTextAlignment(.center)
                    // TextField spacing.
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(borderStyleView())

                    //2 탭바 : 배달주문 / 포장/방문 주문
                    //배달주문 최소주문금액 , 결제 방법 , 배달 시간 , 배달팁
                    deliveryOrpackagingTopTabBar(storeRegiVM: storeRegiVM, tabIndex: 0 , isText: false)
                    //최소주문금액 /이용방법 /픽업 시간/ 위치 안내 (지도) / 결제방법
                } //VStack
                .background(Color.white)

                VStack{
                    //3 탭바 : 메뉴 / 정보 / 리뷰
                    MenuOrInformaOrReview(storeRegiVM: storeRegiVM,tabIndex: 0 , isStoreRegister: true)
                }.background(Color.white)
            }
    //            //.background(Color(hex: 0xEFEFEF))//ScrollView
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                .onAppear(perform: {
                        homeState.isHiddenTap()
                })
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
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
                                                Text("내 가게 등록").foregroundColor(Color.black)

                                            }
                                         }
                                    }
                               }//ToolbarItem.
                    }
                .navigationBarBackground({
                    Color.white
            })

            MyStoreRegiButton(storeRegiVM: storeRegiVM)

        } // Zstack


    }
}

struct MyStoreRegiButton : View {
    @ObservedObject var storeRegiVM: StoreRegisterViewModel

    var body: some View {

        HStack{

                Button(action: {
                    storeRegiVM.add()

                }, label: {
                    HStack{
                        Text("가게 등록하기")
                    }
                    .font(.system(size:20 , weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(width: 250, height: 50)
                }).background(Color.black)
                    .cornerRadius(10)
                    .padding(10)

        } //HStack
        .background(Color.white)
    }
}

struct MyStoreRegisterView_previews : PreviewProvider {

    static var previews : some View {
        MyStoreRegisterView(homeState: HomeState())
    }
}

