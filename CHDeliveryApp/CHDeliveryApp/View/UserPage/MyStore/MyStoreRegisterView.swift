//
//  MyStoreRegisterView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/11.
//

import Foundation
import SwiftUI



struct MyStoreRegisterView : View {
    @ObservedObject var storeVM : StoreViewModel 
    
    @Environment(\.dismiss) private var dismiss
    var imageconversion : ImageConversion = ImageConversion()

    @ObservedObject var homeState : HomeState
    var isRegister : Bool
    var storeData : Store
    var isEdit : Bool

    
    @State var image : Image?
    @State var selectedUIImage : UIImage?
    @State var showImagePicker = false
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
        
        let imageData = selectedUIImage!.jpegData(compressionQuality: 0.5)! as NSData
        storeVM.storeImage = imageData
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
                            if(isRegister){
                                VStack{
                                    Text("대표 사진 등록").foregroundColor(Color.black)
                                    Image(systemName: "plus.app.fill")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 50))
                                }.padding(.vertical, 20)
                            }else{
                                image?
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .ignoresSafeArea(edges: .top)
                                    .frame(height: 170)
                                    .clipped()
                                    .padding(.bottom , 20)
                            }

                        }


                    })
                        .onAppear{
                            //초기화
                            if(!isRegister){
                                //가게 기본정보
                                image = imageconversion.getImage(_image: storeData.storeMainImage!)
                                
                            }
                            
                        }
                        .sheet(isPresented: $showImagePicker, onDismiss: {
                            loadImage()
                            //imageChangeWhether = true
                        }) {
                            ImagePicker(image: $selectedUIImage)
                        }
                    
                    //Title
                    if(isRegister){
                        TextField("가게 이름 입력", text: $storeVM.storeName)
                            .frame(width: 150)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fixedSize(horizontal: true, vertical: false)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(borderStyleView())
                    }else{
                            TextField("\(storeData.storeName)", text: $storeVM.storeName)
                                .frame(width: 150)
                                .textFieldStyle(PlainTextFieldStyle())
                                .fixedSize(horizontal: true, vertical: false)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(borderStyleView())
                                .onAppear{
                                    storeVM.storeName = storeData.storeName
                                }
                        

                    }

                    

                    //2 탭바 : 배달주문 / 포장/방문 주문
                    //배달주문 최소주문금액 , 결제 방법 , 배달 시간 , 배달팁
                        deliveryOrpackagingTopTabBar(storeData: storeData, storeRegiVM: storeVM, tabIndex: 0 , isStoreView: false , isEdit: isEdit)



                    //최소주문금액 /이용방법 /픽업 시간/ 위치 안내 (지도) / 결제방법
                } //VStack
                .background(Color.white)

                VStack{
                    //3 탭바 : 메뉴 / 정보 / 리뷰
                        MenuOrInformaOrReview( storeData : storeData ,storeRegiVM: storeVM,tabIndex: 0 , isStoreRegister: true , isEdit: isEdit)


                }.background(Color.white)
            }
    //            //.background(Color(hex: 0xEFEFEF))//ScrollView
            .padding(.bottom , 70)
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

            MyStoreRegiButton(homeState : homeState ,storeRegiVM: storeVM , storeData: storeData, isRegister: isRegister)

        } // Zstack


    }
}


struct MyStoreRegiButton : View {
    @ObservedObject var homeState : HomeState
    @ObservedObject var storeRegiVM: StoreViewModel
    var storeData : Store
    var isRegister : Bool
    @Environment(\.dismiss) private var dismiss
    var body: some View {

        HStack{

                Button(action: {
                    homeState.isVisibilityTap()
                    if(isRegister){
                        //등록
                        storeRegiVM.addStore()
                    }else{
                        //수정
                        storeRegiVM.editStore(old: storeData)
                    }

                    dismiss()
                }, label: {
                    HStack{
                        if(isRegister){
                            Text("가게 등록하기")
                        }else{
                            Text("가게 수정하기")
                        }
                        
                    }
                    .font(.system(size:20 , weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(width: 250, height: 50)
                }).background(Color.black)
                    .cornerRadius(10)
                    .padding(10)

        } //HStack
        .frame(maxWidth: .infinity)
        .background(Color.white)

    }
}


